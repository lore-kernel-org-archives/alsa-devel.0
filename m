From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: too many alsamixer sliders
Date: Mon, 29 Apr 2002 19:45:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CCD94B8.6040206@superbug.demon.co.uk>
References: <20020426124115.71b29205.mdeboer@iua.upf.es>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tele-post-20.mail.demon.net (tele-post-20.mail.demon.net [194.217.242.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22599
	for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2002 20:44:45 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Maarten de Boer wrote:

>Hello,
>
>Updating my fltk alsamixer frontend, alsamixergui, I once again
>found that alsamixer (and therefore alsamixergui) shows a lot
>of sliders. With my Audigy, it's really too much. I think it
>would be very nice to be able to configure alsamixer, to show
>only a subset of sliders. I guess a .alsamixerrc file in the
>users homedirectory. But maybe the /etc/asound.state could be
>used for that as well? It would be nice to have several presets
>or groups..
>
>Do you have any suggestions about how to do this? I would not
>mind implementing it (I think it's won't be to much work), but
>I'd like to have your opinion first.
>
>Maarten
>
>  
>
Maybe having a key in alsamixer to switch between playback and capture 
sliders groups.
Currently, playback and capture sliders are side by side, creating a 
rather long line of sliders.

Cheers
James
