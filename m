From: Tim Goetze <tim@quitte.de>
Subject: Re: Select call  with alsa
Date: Wed, 7 Jan 2004 13:08:04 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401071303290.507@autumn>
References: <Law10-F77UPMUdjhexa0003b7a3@hotmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Law10-F77UPMUdjhexa0003b7a3@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alex Lau <lau2468@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alex Lau wrote:

>I had done some search on the internet about using select(2) with
>alsa and found the function snd_pcm_file_descriptor(
>*snd_pcm_handle_t). However when I try to test it with a simple
>program, I got compliation error of fundefined reference. I also try
>to lokk it up in the library documentation buit from the source code
>but unable to find such function.
>
>Can someone direct me to a suitable document about this function?

you seem to be looking for

snd_pcm_poll_descriptors_count (...) and
snd_pcm_poll_descriptors (...)

hth,

tim

ps: from my experience, poll(2) is a better replacement for select(2).


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
