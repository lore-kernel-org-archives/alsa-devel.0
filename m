From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_close simple question
Date: Wed, 19 Feb 2003 08:27:15 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302190826150.2755-100000@studcom.urz.uni-halle.de>
References: <1045607706.19274.102.camel@shippin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1045607706.19274.102.camel@shippin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ljp <ljp@llornkcor.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

ljp wrote:
> does snd_pcm_close free a snd_pcm_hw_params_t that was
> snd_pcm_hw_params_malloc 'd?  I presume I need to free that?

No. Yes.

The same snd_pcm_hw_params_t could be used to get/set the parameters of
another pcm.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
