From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: How to get set/fixed sample rate of ALSA device?
Date: Mon, 08 Oct 2007 00:07:37 +0200
Message-ID: <470958A9.7040607@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>	<4708F918.3060207@keyaccess.nl>
	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020100030405010603010506"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Peteris Krisjanis <pecisk@gmail.com>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020100030405010603010506
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/2007 07:04 PM, Peteris Krisjanis wrote:

>> "Current sample rate" only has meaning with the device open , and if I 
>> understand you right, a "cat
>> /proc/asound/card0/pcm0{p,c}/sub0/hw_params will then get you what you
>> want as to the "get" part (substitute for 0 in the above as required).
> 
> I actually meant what kind of sample rate is set in sound card. For 
> example, my onboard sound card has fixed Hz. I would like to know such 
> information _before_ I touch sound card :)

Okay, you want the information that the driver author supplied in the struct 
snd_pcm_hardware for the stream. I've in fact also wanted that information 
on a number of occasions and just looked at the driver source then.

> So you suggest to open device via any means and then read that file? I
> did this and it works.
> I guess I can even try to implement it in app and check for sample
> rate everytime before I play.
> 
> But is this only solution? It's rather hack, and I would like to have
> more reliable method.

You might consider this less of of a hack -- it uses the ALSA API to query 
the information from the PCM handle directly. Please see the library 
docoumentation for other information you can extract from a hw_params struct.

(I don't suppose you can ever get anything but dir == 0 for "hw" devices).

Introducing a /proc/asound/card0/pcm0{p,c}/hw_limits or similar might not be 
a bad idea though?

Rene

--------------020100030405010603010506
Content-Type: text/plain;
 name="snd_rate.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snd_rate.c"

/* gcc -W -Wall -o snd_rate snd_rate.c -l asound */

#include <stdio.h>
#include <alsa/asoundlib.h>

int main(void)
{
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *params;
	unsigned int val;
	int dir;
	int err;

	snd_pcm_hw_params_alloca(&params);

	err = snd_pcm_open(&handle, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0);
	if (err < 0) {
		fprintf(stderr, "snd_pcm_open: %s\n", snd_strerror(err));
		return -1;
	}

	err = snd_pcm_hw_params_any(handle, params);
	if (err < 0) {
		fprintf(stderr, "snd_pcm_hw_params_any: %s\n",
			snd_strerror(err));
		return -1;
	}
	err = snd_pcm_hw_params_get_rate_min(params, &val, &dir);
	if (err < 0) {
		fprintf(stderr, "snd_pcm_hw_params_get_rate_min: %s\n",
			snd_strerror(err));
		return -1;
	}
	printf("min: (%c) %u\n", "<=>"[dir + 1], val);

	err = snd_pcm_hw_params_get_rate_max(params, &val, &dir);
	if (err < 0) {
		fprintf(stderr, "snd_pcm_hw_params_get_rate_max: %s\n",
			snd_strerror(err));
		return -1;
	}
	printf("max: (%c) %u\n", "<=>"[dir + 1], val);

	snd_pcm_close(handle);
	return 0;
}

--------------020100030405010603010506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------020100030405010603010506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------020100030405010603010506--
