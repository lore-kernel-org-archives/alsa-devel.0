From: "Aldrin Martoq" <amartoq@dcc.uchile.cl>
Subject: Re: [PATCH] alsa-lib: issues in snd_seq_change_bit and
	some enhancements
Date: Thu, 21 Feb 2008 06:12:19 -0300
Message-ID: <17eedd8a0802210112k548c1e0fx4c6cf04bfc9ae780@mail.gmail.com>
References: <1203577712.13752.33.camel@localhost> <47BD2F61.7070103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 96B932443F
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 10:12:21 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so1229013wfa.23
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 01:12:20 -0800 (PST)
In-Reply-To: <47BD2F61.7070103@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2008 at 4:59 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Aldrin Martoq wrote:
>  > 2) There is no sane way to clear the event_filter of
>  > snd_seq_client_info_t structure. Because the structure is opaque, we
>  > cannot memset to zero because the user doesn't know the size of the
>  > bitmap.
>  The event type is an 8-bit quantity; this is part of the sequencer API.
>  The bitmap has exactly 256 bits, i.e., 32 bytes.
>  It would be nice if this were actually documented ...

Yup, I traced it to the sndrv_seq_client_info definition, but...

I think Takashi explicitly undocumented that stuff. The client_info
and many other types/structures are hidden, the explanation is in the
following link:
typedef struct _snd_seq_client_info snd_seq_client_info_t;
http://www.alsa-project.org/~tiwai/alsa.html#NewSeqAPI

So, my proposal follows the same spirit of hidding internal
structures, which is kind of boring in C. But it's not boring if you
are using some higher language (like python alsaseq, which I'm
currently working on).


Another way to "resolve" this is to create a type instead of the raw
pointer "unsigned char *". Something like:
typedef struct snd_seq_client_info_event_filter {
  unsigned char d[32];
} snd_seq_client_info_event_filter_t;

and use the snd_seq_*_bit functions (btw, I added snd_seq_unset_bit);
but in my opinion, creating functions instead of structures is more in
the spirit of encapsulating the API for future extensions.


What do you think?

-- 
Aldrin Martoq
