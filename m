From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Regarding ALSA Library
Date: Tue, 10 Jun 2003 13:31:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306101326590.6285-100000@pnote.perex-int.cz>
References: <3EE5BBD5.CDB6685D@siptech.co.in>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EE5BBD5.CDB6685D@siptech.co.in>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sundaranathan S <snathan@siptech.co.in>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jun 2003, Sundaranathan S wrote:

> Hi  All,
> 
>         Can anyone explain me what is the purpose of snd_pcm_forward in
> pcm.c.

The forward means exactly what you expect. You can go ahead in the ring
buffer without filling/reading of any samples. It means that affected
changes are not altered like write or mmap does for playback or you can
skip data for capture. It may be useful for realtime applications where
data might be ready in different times (network transfer etc.).

> Also what is the use of __snd_pcm_forward macro and where is it defined.
> I am not able to find any definition for this macro __snd_pcm_forward.

Look for INTERNAL() macro and read carefully the function declaration.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
