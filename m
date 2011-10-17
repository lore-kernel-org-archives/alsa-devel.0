From: "Sebastian H." <vand2@gmx.de>
Subject: Re: How to save playback out in a file too
Date: Mon, 17 Oct 2011 11:56:57 +0200
Message-ID: <4E9BFBE9.1050103@gmx.de>
References: <CAL7V=_Hv+s8kbv3mVLnP2djAGe4nUSdQM76OicgLExZQfjWcug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 4788510383B
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 12:23:42 +0200 (CEST)
In-Reply-To: <CAL7V=_Hv+s8kbv3mVLnP2djAGe4nUSdQM76OicgLExZQfjWcug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ajay khandelwal <ajay.lforum@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Hi,
>  I want to same output of playback in a file.
> 
> We are developing IEC958 device but to debug want to save output of IEC958
> plug in a file.
> 
> Please suggest how to do that?

You could use the "file" plugin.
Extend your ~/.asoundrc with something like

pcm.write_file {
	type file
	slave {
		pcm hw:0
	}
	file "/home/user/alsafile.wav"
	format "wav"
}


Then use the "write_file" device for playback.
E.g. for mplayer
mplayer -ao alsa:device=write_file myvideo.mkv

Sebastian
