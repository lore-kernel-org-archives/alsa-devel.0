From: Andy Lo A Foe <andy@alsaplayer.org>
Subject: Re: [Alsaplayer-devel]error trying to run alsaplayer on ppc
Date: Sat, 18 May 2002 11:57:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020518095743.GA8039@orbital.xs4all.nl>
References: <1021659988.25764.35.camel@bennyhill.belmont>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1021659988.25764.35.camel@bennyhill.belmont>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: matt yee-king <yeeking@no-future.com>
Cc: alsaplayer-devel@lists.tartarus.org, howarth@bromo.med.uc.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, May 17, 2002 at 06:26:22PM +0000, matt yee-king wrote:

> [root@bennyhill alsaplayer-0.99.70]# alsaplayer
> alsaplayer: pcm.c:5655: snd_pcm_unlink_ptr: Assertion `0' failed.
> AlsaPlayer interrupted by signal 6

I've installed the latest CVS, but can't reproduce this. It might be a
powermac specific driver problem? Since I don't call this function
directly from within the alsa output plugin I have no way of knowing
when this gets called, and why it fails :( Perhaps Takashi can tell us
more about it?!

Regards,
Andy

_______________________________________________________________
Hundreds of nodes, one monster rendering program.
Now that's a super model! Visit http://clustering.foundries.sf.net/
