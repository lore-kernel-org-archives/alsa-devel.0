From: Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: Q: How to detect which USx2y is connected?
Date: Tue, 13 Feb 2007 18:08:03 +0000
Message-ID: <45D1FE83.7000301@rncbc.org>
References: <20070205065636.GA1652@elte.hu>
	<45CDE6B9.80804@rncbc.org>	<23912.194.65.103.1.1171382877.squirrel@www.rncbc.org>	<200702131836.36010.annabellesgarden@yahoo.de>
	<s5hire6c5jo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070405060006020507090002"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hire6c5jo.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070405060006020507090002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 13 Feb 2007 18:36:35 +0100,
> Karsten Wiese wrote:
>> Hi Rui,
>>
>> Am Dienstag, 13. Februar 2007 schrieb Rui Nuno Capela:
>>> Hi Karsten,
>>>
>>> In my quest in completing us428control implementation, I'm now stumbling
>>> on a fundamental question regarding the number of tracks/channel-faders
>>> (per bank) each particular usx2y device supports. The question boils down
>>> to what is the actual numeric value of the y in the actual usx2y model
>>> name :)
>>>
>>> In practice, I need to know which usx2y model is actually connected.
>>>
>>> So, what is the best/deterministic way to detect (programmatically)
>>> whether us428control is connecting to a US224 (y=4, as mine) _or_ a US428
>>> (y=8, as yours) ?
>>>
>>> Is snd_hwdep_info_get_name() expected to be the most correct method?
>> Yes, I fear. this gives the /proc/bus/usb/002/004 filename.
>> I just did cat /proc/bus/usb/004/005 > x
>> and check x with hexedit: the 1604 and 8001 is in there.
>> I don't know how to portably interpret a read from
>> /proc/bus/usb/004/005 though.
> 
> Note that /proc/bus/usb is deprecated on many distros...
> 

How about using snd_pcm_hw_params_get_channels_max() ?
At least on capture the US224 should give 2 and the US428 should give 4
as the maximum number of channels.

It would be handful for me if the attached test program could be ran
against a US428, just for the records ;)

On my US224 it gives:

$ snd_hwdep_info hw:3
---hwdep---
snd_hwdep_info_get_id   (hw:3) = 'USX2Y Loader'
snd_hwdep_info_get_name (hw:3) = '/proc/bus/usb/001/004'
---pcm (capture)---
snd_pcm_hw_params_get_channels_min(hw:3) = 2
snd_pcm_hw_params_get_channels_max(hw:3) = 2
---pcm (playback)---
snd_pcm_hw_params_get_channels_min(hw:3) = 2
snd_pcm_hw_params_get_channels_max(hw:3) = 2

Karsten?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

--------------070405060006020507090002
Content-Type: text/plain;
 name="snd_hwdep_info.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd_hwdep_info.c"

#include <stdio.h>
#include <stdlib.h>

#include <alsa/asoundlib.h>

/**
	Vendor / Product ID
    0x1604 / 0x8001 (US428)
	0x1604 / 0x8005 (US224)
	0x1604 / 0x8007 (US122)
*/
int print_hwdep_info ( const char *name )
{
	snd_hwdep_t *hwdep = NULL;
	snd_hwdep_info_t *hwdep_info;
	int err;

	if ((err = snd_hwdep_open(&hwdep, name,
			SND_HWDEP_OPEN_READ | SND_HWDEP_OPEN_NONBLOCK)) < 0) {
		fprintf(stderr, "snd_hwdep_open(%s): %s\n", name, snd_strerror(err));
		return err;
	}

	snd_hwdep_info_alloca(&hwdep_info);
	if ((err = snd_hwdep_info(hwdep, hwdep_info)) < 0) {
		fprintf(stderr, "snd_hwdep_info(%s): %s\n", name, snd_strerror(err));
	} else {
		printf("snd_hwdep_info_get_id   (%s) = '%s'\n", name, snd_hwdep_info_get_id(hwdep_info));
		printf("snd_hwdep_info_get_name (%s) = '%s'\n", name, snd_hwdep_info_get_name(hwdep_info));
	}

	if ((err = snd_hwdep_close(hwdep)) < 0)
		fprintf(stderr, "snd_hwdep_close(%s): %s\n", name, snd_strerror(err));
	
	return err;
}

int print_pcm_info ( const char *name, int stream )
{
	snd_pcm_t *pcm;
	snd_pcm_hw_params_t *hw_params;
	unsigned int channels;
	int err;
	
	if ((err = snd_pcm_open(&pcm, name, stream, SND_PCM_NONBLOCK)) < 0) {
		fprintf(stderr, "snd_pcm_open(%s): %s\n", name, snd_strerror(err));
		return err;
	}

	snd_pcm_hw_params_alloca(&hw_params);
	if ((err = snd_pcm_hw_params_any(pcm, hw_params)) < 0) {
		fprintf(stderr, "snd_pcm_hw_params_any(%s): %s\n", name, snd_strerror(err));
	} else {
		if ((err = snd_pcm_hw_params_get_channels_min(hw_params, &channels)) < 0) {
			fprintf(stderr, "snd_pcm_hw_params_get_channels_min(%s): %s\n", name, snd_strerror(err));
		} else {
			printf("snd_pcm_hw_params_get_channels_min(%s) = %u\n", name, channels);
		}
		if ((err = snd_pcm_hw_params_get_channels_max(hw_params, &channels)) < 0) {
			fprintf(stderr, "snd_pcm_hw_params_get_channels_max(%s): %s\n", name, snd_strerror(err));
		} else {
			printf("snd_pcm_hw_params_get_channels_max(%s) = %u\n", name, channels);
		}
	}

	if ((err = snd_pcm_close(pcm)) < 0)
		fprintf(stderr, "snd_pcm_close(%s): %s\n", name, snd_strerror(err));
	
	return err;
}


int main ( int argc, char *argv[] )
{
	int i;

	for (i = 1; i < argc; ++i) {
		const char *name = argv[i];
		printf("---hwdep---\n");
		print_hwdep_info(name);
		printf("---pcm (capture)---\n");
		print_pcm_info(name, SND_PCM_STREAM_CAPTURE);
		printf("---pcm (playback)---\n");
		print_pcm_info(name, SND_PCM_STREAM_PLAYBACK);
	}
}

--------------070405060006020507090002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------070405060006020507090002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070405060006020507090002--
