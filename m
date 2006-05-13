From: "Stefano D Angelo" <daste@oneonline.it>
Subject: trouble with constraint rules - Line6 TonePort UX1 USB driver
Date: Sat, 13 May 2006 12:46:19 +0300
Message-ID: <20060513124619.M13417@oneonline.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I'm having troubles setting hardware constraint rules. What I need to do is
setting the period size once I know the rate requested by the application.
The settings are these: 44100 Hz <-> 45 * 2 frames per period, 48000 Hz <-> 48
* 2 frames per period.
Since the card supports four format/rate settings, I set playback_hw this way:

static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {
	.info             = SNDRV_PCM_INFO_INTERLEAVED,
	.formats          = SNDRV_PCM_FMTBIT_S16_LE |
	                    SNDRV_PCM_FMTBIT_S24_3LE,
	.rates            = SNDRV_PCM_RATE_44100 |
	                    SNDRV_PCM_RATE_48000,
	.rate_min         = 44100,
	.rate_max         = 48000,
	.channels_min     = 2,
	.channels_max     = 2,
	/* double buffering */
	.buffer_bytes_max = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT * 1024 * 2,
	.period_bytes_min = LINE6_TP_UX1_44100_16_PACKET_SIZE_OUT * 2,
	.period_bytes_max = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT * 2,
	.periods_min      = 1,
	.periods_max      = 1024
};

Then in playback open callback i put this:

if ((err = snd_pcm_hw_rule_add (runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
                                snd_line6_tp_ux1_hw_period_by_rate, 0,
                                SNDRV_PCM_HW_PARAM_PERIOD_SIZE, -1)));

The function that actually should make this work is:

static int snd_line6_tp_ux1_hw_period_by_rate (snd_pcm_hw_params_t *params,
                                               snd_pcm_hw_rule_t *rule)
{
	snd_interval_t *p = hw_param_interval (params,
	                                       SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
	snd_interval_t *r = hw_param_interval (params,
	                                       SNDRV_PCM_HW_PARAM_RATE);
	snd_interval_t p_size;
	
	snd_interval_any (&p_size);
	if (r->min == r->max) {
		if (r->min == 48000) {
			p_size.min = p_size.max = 48 * 2;
			p_size.integer = 1;
			return snd_interval_refine (p, &p_size);
		}

		p_size.min = p_size.max = 45 * 2;
		p_size.integer = 1;
		return snd_interval_refine (p, &p_size);
	}

	return 0;
}

To understand the code you should also know the following lines:

/* 48 kHz, 16-bits */
#define LINE6_TP_UX1_48000_16_ALTSETTING        1
#define LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT 192
#define LINE6_TP_UX1_48000_16_PACKET_SIZE_IN  200

/* 44.1 kHz, 16-bits */
#define LINE6_TP_UX1_44100_16_ALTSETTING        2
#define LINE6_TP_UX1_44100_16_PACKET_SIZE_OUT 180
#define LINE6_TP_UX1_44100_16_PACKET_SIZE_IN  188

/* 48 kHz, 24-bits */
#define LINE6_TP_UX1_48000_24_ALTSETTING        3
#define LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT 288
#define LINE6_TP_UX1_48000_24_PACKET_SIZE_IN  300

/* 44.1 kHz, 24-bits */
#define LINE6_TP_UX1_44100_24_ALTSETTING        4
#define LINE6_TP_UX1_44100_24_PACKET_SIZE_OUT 270
#define LINE6_TP_UX1_44100_24_PACKET_SIZE_IN  282

These last defines specify the size in bytes of the endpoints of the sound
card, that is the size in bytes that periods should have at different
combinations of format/rate. However you can notice that 44100 Hz, 16-bits and
44100 24-bits endpoint sizes in frames (24-bits to be considered as 3 bytes)
is 45, and also 48000 Hz endpoints sizes have a precise value: 48.
Since the card is USB, I need to split the data in packets whose size is (for
double buffering reasons) twice the corrispondent period size (and this
depends only on rate as we've seen).
What happnes is this (using aplay): snd_line6_tp_ux1_hw_period_by_rate is
called four times for a single playback open and the rate is actually set
(r->min == r->max) only in the last call. The four calls happen because not
only because of rate setting, but also format setting and period size setting.
And that's the problem: ALSA automatically sets the period size according to
the format and period_bytes_min & max in playback_hw struct, before the
drivers can know what is the actual rate. And it tries to set the period at
the maximum value.
The result is that this card works for 48 kHz, 24-bits streams, because
period_bytes_max in frames is exactly 96 (48 * 2), but all other format/rate
combination do not work.
For example what happens at 44.1 kHz 16-bits is this: first ALSA sets the
period interval having the minimum equal to 60 (period_bytes_min in frames in
S24_3LE format) and the maximum is 144 (period_bytes_max in frames in S16_LE
format); then the format is set and the minimum becomes 90 (perdiod_bytes_min
in frames in S16_LE format); then it sets the period size at the maximum
avaible (min = max = 144) and only at this point the rate setting is made, but
this way the period size cannot be set at the value it should have, that
should be 90 (45 * 2) frames per period.
This is really getting me frustrated, PLEASE HELP ME!

Stefano D'Angelo

P.S.: did you receive the full driver source?

-----------------
Registra il tuo nome di dominio su: http://www.oneonline.it/domini
One On Line ti offre domino + spazio web illimitato + 5 email + 5000 uscite banner + PHP + Link a soli Euro 15 iva compresa



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
