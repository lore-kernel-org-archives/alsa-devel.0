From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: snd_pcm_rewind() weirdness
Date: Thu, 24 Apr 2008 02:34:34 +0200
Message-ID: <20080424003434.GA27865@tango.0pointer.de>
References: <20080419233738.GA18371@tango.0pointer.de>
	<Pine.LNX.4.61.0804210855520.7882@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id ADE3624757
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 02:34:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0804210855520.7882@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 21.04.08 08:58, Jaroslav Kysela (perex@perex.cz) wrote:

> 
> On Sun, 20 Apr 2008, Lennart Poettering wrote:
> 
> > Hey!
> > 
> > On ALSA 1.0.16 with the HDA driver I am experiencing some weird things
> > with snd_pcm_rewind() which I think are the result of a kernel bug,
> > but I am not sure.
> 
> What alsa-lib plugins are on path? It looks like a rate plugin issue. Post 
> also snd_pcm_dump() output. Driver does not do any alignment.

It's front:0. I don't think the rate plugin is used. 

Device is being opened with
SND_PCM_NO_AUTO_RESAMPLE|SND_PCM_NO_AUTO_CHANNELS|SND_PCM_NO_AUTO_FORMAT
and snd_pcm_hw_params_set_rate_resample(..., 0).

That should get me only softvol, right?

The output of snd_pcm_dump() is here (please ignore the "D:
alsa-util.c" prefix)

<snip>
D: alsa-util.c: Soft volume PCM
D: alsa-util.c: Control: PCM Playback Volume
D: alsa-util.c: min_dB: -51
D: alsa-util.c: max_dB: 0
D: alsa-util.c: resolution: 256
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 31001
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 4611686018427387904
D: alsa-util.c: Slave: Hardware PCM card 4 'HDA Intel' device 0 subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 31001
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 4611686018427387904
</snip>

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
