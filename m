From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [Alsa-devel] Re: copy pcm plugin
Date: Wed, 28 Jan 2004 22:30:23 +0100
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040128223023.1a6d05e0.mista.tapas@gmx.net>
References: <20040128180546.4cc88584.mista.tapas@gmx.net>
	<s5hllns5603.wl@alsa2.suse.de>
	<s5hbronucb8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hbronucb8.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Jan 2004 20:02:03 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 28 Jan 2004 18:37:32 +0100,
> I wrote:
> > 
> > At Wed, 28 Jan 2004 18:05:46 +0100,
> > Florian Schmidt wrote:
> > > 
> > > 
> > > Hi, as far as i understand it, the copy plugin does nothing but
> > > copy its input to its output. I wonder if it would be easily
> > > possible to extend this plugin to copy to multiple slave pcms.
> > > This way it would be(easily?) possible to "distribute" a stereo
> > > signal to 4 or even 6 channels.
> > 
> > route (and plug) plugin already can do that.
> > for example,
> 
> ah, in your question, multiple slave pcms are assumed.
> in such a case, combine the multiple pcms via multi plugin at first,
> then use route plugin over it.

Well, i thought i would need to somehow copy to front/rear, etc,
manually. But just using the surround51 or surround40 as slave pcm
sounds just as good. Thanks, Takashi and Jaroslav for the quick infos :)
I will add them to the wiki soon..

Flo

-- 
signature :)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
