From: =?utf-8?Q?Jon_Harald_=C3=98ymyr?= <joymyr@gmail.com>
Subject: C API, usage of function _snd_pcm_file_open()
Date: Thu, 10 Feb 2011 16:49:06 +0100 (CET)
Message-ID: <30083061.18.1297352942734.JavaMail.jon@TT-WS-002>
References: <21273028.14.1297352791843.JavaMail.jon@TT-WS-002>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id A9EB524562
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 16:48:55 +0100 (CET)
Received: by ewy19 with SMTP id 19so768795ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 07:48:55 -0800 (PST)
In-Reply-To: <21273028.14.1297352791843.JavaMail.jon@TT-WS-002>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I had a look at the Spotify C API, and found that they were using the following code to output music from Spotify: snd_pcm_open(&h, dev, SND_PCM_STREAM_PLAYBACK, 0).

I want use this function instead: 
int _snd_pcm_file_open(snd_pcm_t **pcmp, const char *name, snd_config_t *root, snd_config_t *conf, snd_pcm_stream_t stream, int mode)

The function is found here: 
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm__file_8c.html#94d0dc725e55a974d792e16f8abdc60a

I'm not able to find anything in the documentation explaining what the two parameters snd_config_t *root and snd_config_t *conf is.

What I'm trying to achieve is to write the stream to a file, and then read it from another application. But it would be even better if I could make the C application write to standard output.

Can anybody help me with this?
I'm not very experienced with either C programming or streaming, but I would really like to make this work.
