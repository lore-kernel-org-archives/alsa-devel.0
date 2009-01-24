From: Jaswinder Singh Rajput <jaswinderlinux@gmail.com>
Subject: Re: usr/include/linux/soundcard.h warnings for 'make headers_check'
Date: Sat, 24 Jan 2009 12:20:03 +0530
Message-ID: <3f9a31f40901232250i27a673a9r8b0620f968e351e1@mail.gmail.com>
References: <1232465902.3088.31.camel@localhost.localdomain>
	 <s5h7i4psepm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751822AbZAXGuW@vger.kernel.org>
In-Reply-To: <s5h7i4psepm.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>, alsa-devel@alsa-project.org, Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 21, 2009 at 5:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 20 Jan 2009 21:08:22 +0530,
> Jaswinder Singh Rajput wrote:
>>
>> usr/include/linux/soundcard.h is giving following warnings for 'make headers_check':
>>  usr/include/linux/soundcard.h:1047: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1048: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1049: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1050: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1051: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1053: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1055: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1056: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1061: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1062: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1078: extern's make no sense in userspace
>>  usr/include/linux/soundcard.h:1079: extern's make no sense in userspace
>>
>> Do we need to fix these warnings.
>
> No, these are declarations for OSS-lib.
> It doesn't belong to kernel, but it's better to keep it for
> compatibility in some way.
>

Do you find some better place for:

void seqbuf_dump(void); /* This function must be provided by programs */

extern int OSS_init(int seqfd, int buflen);
extern void OSS_seqbuf_dump(int fd, unsigned char *buf, int buflen);
extern void OSS_seq_advbuf(int len, int fd, unsigned char *buf, int buflen);
extern void OSS_seq_needbuf(int len, int fd, unsigned char *buf, int buflen);
extern void OSS_patch_caching(int dev, int chn, int patch,
                              int fd, unsigned char *buf, int buflen);
extern void OSS_drum_caching(int dev, int chn, int patch,
                              int fd, unsigned char *buf, int buflen);
extern void OSS_write_patch(int fd, unsigned char *buf, int len);
extern int OSS_write_patch2(int fd, unsigned char *buf, int len);
..

#ifdef OSSLIB
#  define SEQ_USE_EXTBUF() \
                extern unsigned char *_seqbuf; \
                extern int _seqbuflen;extern int _seqbufptr
#  define SEQ_DEFINEBUF(len) SEQ_USE_EXTBUF();static int
_requested_seqbuflen=len
#  define _SEQ_ADVBUF(len) OSS_seq_advbuf(len, seqfd, _seqbuf, _seqbuflen)
#  define _SEQ_NEEDBUF(len) OSS_seq_needbuf(len, seqfd, _seqbuf, _seqbuflen)
#  define SEQ_DUMPBUF() OSS_seqbuf_dump(seqfd, _seqbuf, _seqbuflen)

#  define SEQ_LOAD_GMINSTR(dev, instr) \
                OSS_patch_caching(dev, -1, instr, seqfd, _seqbuf, _seqbuflen)
#  define SEQ_LOAD_GMDRUM(dev, drum) \
                OSS_drum_caching(dev, -1, drum, seqfd, _seqbuf, _seqbuflen)
#else /* !OSSLIB */

#  define SEQ_LOAD_GMINSTR(dev, instr)
#  define SEQ_LOAD_GMDRUM(dev, drum)

#  define SEQ_USE_EXTBUF() \
                extern unsigned char _seqbuf[]; \
                extern int _seqbuflen;extern int _seqbufptr

..

what are your plans.

--
JSR
