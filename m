From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: How to get set/fixed sample rate of ALSA device?
Date: Tue, 09 Oct 2007 02:23:35 +0200
Message-ID: <470ACA07.8080407@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>
	<4708F918.3060207@keyaccess.nl>
	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>
	<470958A9.7040607@keyaccess.nl>
	<b97f4ee40710081209k1ba59df3g491387b681f8bbe3@mail.gmail.com>
	<Pine.LNX.4.64.0710081212360.32693@info.physics.ubc.ca>
	<470A8562.50301@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000501020104040202090100"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <470A8562.50301@keyaccess.nl>
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
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>, Bill Unruh <unruh@physics.ubc.ca>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000501020104040202090100
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2007 09:30 PM, Rene Herman wrote:

> On 10/08/2007 09:14 PM, Bill Unruh wrote:

>>>> Introducing a /proc/asound/card0/pcm0{p,c}/hw_limits or similar might
>>>>  not be a bad idea though?

[ ... ]

> It could also be done in userspace by opening the stream and quering the 
> format_mask, channels and rates and stuff and I'll look into that a bit 
> as a followup to the rates_min/max thing that I posted if only as a 
> template thingy, but unless I'm missing it, I don't believe there's 
> actually a way to get the information from userspace without opening the 
> "hw" device, and that one only allows "subdevices_count" concurrent 
> opens, meaning you'd have to stop things talking to your soundcard if it 
> has just one (normal).

Okay, well, in userspace it would be something like this.

Not too sure about that subformat thing by the way. Jaroslav (or anyone, 
obviously): is the subformat intended/designed to be format-specific or 
snd_pcm_t global?

Currently there is only ever one subformat (STD) anyway but generally, I'd 
expect a subformat to be specific to a given format. There's just one non 
format-specific SND_PCM_SUBFORMAT_LAST though, no defines (or functions) to 
get subformats from the format. Is the design that all formats would be 
supporting all subformats or something?

This is modelled after the hw_params file in an opened substream directory 
(and ignores the possibility of anything more involved than simple min-max 
intervals). Provide a "-c" for the capture direction.

Not sure if this helps much (other than hopefully teaching me about subformats).

Rene


--------------000501020104040202090100
Content-Type: text/plain;
 name="ainfo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ainfo.c"

/* gcc -W -Wall -o ainfo ainfo.c -lasound */

#include <stdio.h>
#include <unistd.h>
#include <alsa/asoundlib.h>

#define DEVICE "hw:0,0"
#define STREAM SND_PCM_STREAM_PLAYBACK

void snd_perror(const char *s, int err)
{
	fprintf(stderr, "%s: %s\n", s, snd_strerror(err));
}

int hw_params_access(snd_pcm_hw_params_t *params)
{
	snd_pcm_access_mask_t *mask;
	snd_pcm_access_t val;
	int err;

	err = snd_pcm_access_mask_malloc(&mask);
	if (err < 0) {
		snd_perror("snd_pcm_acess_mask_malloc", err);
		return err;
	}
	snd_pcm_hw_params_get_access_mask(params, mask);

	printf("access:");
	for (val = 0; val <= SND_PCM_ACCESS_LAST; val++)
		if (snd_pcm_access_mask_test(mask, val))
			printf(" %s", snd_pcm_access_name(val));
	printf("\n");

	snd_pcm_access_mask_free(mask);
	return 0;
}

int hw_params_format(snd_pcm_hw_params_t *params)
{
	snd_pcm_format_mask_t *mask;
	snd_pcm_format_t val;
	int err;

	err = snd_pcm_format_mask_malloc(&mask);
	if (err < 0) {
		snd_perror("snd_pcm_format_mask_malloc", err);
		return err;
	}
	snd_pcm_hw_params_get_format_mask(params, mask);

	printf("format:");
	for (val = 0; val <= SND_PCM_FORMAT_LAST; val++)
		if (snd_pcm_format_mask_test(mask, val))
			printf(" %s", snd_pcm_format_name(val));
	printf("\n");

	snd_pcm_format_mask_free(mask);
	return 0;
}

int hw_params_subformat(snd_pcm_hw_params_t *params)
{
	snd_pcm_subformat_mask_t *mask;
	snd_pcm_subformat_t val;
	int err;

	err = snd_pcm_subformat_mask_malloc(&mask);
	if (err < 0) {
		snd_perror("snd_pcm_subformat_mask_malloc", err);
		return err;
	}
	snd_pcm_hw_params_get_subformat_mask(params, mask);

	printf("subformat:");
	for (val = 0; val <= SND_PCM_SUBFORMAT_LAST; val++)
		if (snd_pcm_subformat_mask_test(mask, val))
			printf(" %s", snd_pcm_subformat_name(val));
	printf("\n");

	snd_pcm_subformat_mask_free(mask);
	return 0;
}

int hw_params_channels(snd_pcm_hw_params_t *params)
{
	unsigned int min;
	unsigned int max;
	int err;

	err = snd_pcm_hw_params_get_channels_min(params, &min);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_channels_min", err);
		return err;
	}
	err = snd_pcm_hw_params_get_channels_max(params, &max);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_channels_max", err);
		return err;
	}
	printf("channels: %u-%u\n", min, max);
	return 0;
}

int hw_params_rate(snd_pcm_hw_params_t *params)
{
	unsigned int min;
	unsigned int max;
	int dir;
	int err;

	err = snd_pcm_hw_params_get_rate_min(params, &min, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_rate_min", err);
		return err;
	}
	err = snd_pcm_hw_params_get_rate_max(params, &max, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_rate_max", err);
		return err;
	}
	printf("rate: %u-%u\n", min, max);
	return 0;
}

int hw_params_period_size(snd_pcm_hw_params_t *params)
{
	snd_pcm_uframes_t min;
	snd_pcm_uframes_t max;
	int dir;
	int err;

	err = snd_pcm_hw_params_get_period_size_min(params, &min, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_period_size_min", err);
		return err;
	}
	err = snd_pcm_hw_params_get_period_size_max(params, &max, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_period_size_max", err);
		return err;
	}
	printf("period_size: %lu-%lu\n", min, max);
	return 0;
}

int hw_params_buffer_size(snd_pcm_hw_params_t *params)
{
	snd_pcm_uframes_t min;
	snd_pcm_uframes_t max;
	int err;

	err = snd_pcm_hw_params_get_buffer_size_min(params, &min);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_buffer_size_min", err);
		return err;
	}
	err = snd_pcm_hw_params_get_buffer_size_max(params, &max);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_buffer_size_max", err);
		return err;
	}
	printf("buffer_size: %lu-%lu\n", min, max);
	return 0;
}

int hw_params_tick_time(snd_pcm_hw_params_t *params)
{
	unsigned int min;
	unsigned int max;
	int dir;
	int err;

	err = snd_pcm_hw_params_get_tick_time_min(params, &min, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_tick_time_min", err);
		return err;
	}
	err = snd_pcm_hw_params_get_tick_time_max(params, &max, &dir);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_get_tick_time_max", err);
		return err;
	}
	printf("tick_time: %u-%u\n", min, max);
	return 0;
}

int hw_params(snd_pcm_t *handle)
{
	snd_pcm_hw_params_t *params;
	int err;

	err = snd_pcm_hw_params_malloc(&params);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_alloc", err);
		return err;
	}
	err = snd_pcm_hw_params_any(handle, params);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_any", err);
		return err;
	}
	err = snd_pcm_hw_params_set_rate_resample(handle, params, 0);
	if (err < 0) {
		snd_perror("snd_pcm_hw_params_set_resample", err);
		return err;
	}

	err = hw_params_access(params);
	if (err < 0)
		return err;

	err = hw_params_format(params);
	if (err < 0)
		return err;

	err = hw_params_subformat(params);
	if (err < 0)
		return err;

	err = hw_params_channels(params);
	if (err < 0)
		return err;

	err = hw_params_rate(params);
	if (err < 0)
		return err;

	err = hw_params_period_size(params);
	if (err < 0)
		return err;

	err = hw_params_buffer_size(params);
	if (err < 0)
		return err;

	err = hw_params_tick_time(params);
	if (err < 0)
		return err;

	snd_pcm_hw_params_free(params);
	return 0;
}

int main(int argc, char *argv[])
{
	const char *device	= DEVICE;
	snd_pcm_stream_t stream = STREAM;

	snd_pcm_t *handle;
	int err;

	while ((err = getopt(argc, argv, "pc")) != -1)
		switch (err) {
		case 'p':
			stream = SND_PCM_STREAM_PLAYBACK;
			break;
		case 'c':
			stream = SND_PCM_STREAM_CAPTURE;
			break;
		case '?':
			return -1;
		}

	if (optind < argc)
		device = argv[optind];

	err = snd_pcm_open(&handle, device, stream, 0);
	if (err < 0) {
		snd_perror("snd_pcm_open", err);
		return err;
	}

	err = hw_params(handle);
	if (err < 0)
		return err;
	
	err = snd_pcm_close(handle);
	if (err < 0) {
		snd_perror("snd_pcm_close", err);
		return err;
	}

	return 0;
}

--------------000501020104040202090100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--------------000501020104040202090100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------000501020104040202090100--
