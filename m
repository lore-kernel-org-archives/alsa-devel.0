From: Mark Knecht <markknecht@attbi.com>
Subject: Re: How do I make -D hw:0,1 default?
Date: 03 Jun 2003 16:51:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054684296.2045.3.camel@Wizard.knechthome.com>
References: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
	 <1054667178.2274.5.camel@Wizard.knechthome.com>
	 <20030604013014.255e4429.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030604013014.255e4429.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-06-03 at 16:30, Florian Schmidt wrote:

> hi..  maybe i can add something.. here's a snippet from my .asoundrc
> 
> pcm.!default {
>         type hw
>         card 0
> }
> 
> ctl.!default {
>         type hw
>         card 0
> }
> 
> 
> this creates a "default" pcm device which can point to any kind of pcm
> device.. here it refers to card 0 which is a hw device. maybe you cann
> add a "device 1" or "subdevice 1" to make it use the right pcm..

Florian,
   Yes. Thanks. This is something Jaroslav pointed out later in the
morning. With this strategy I got at least a simple alsa application to
play sounds cleanly, so this was helpful.

   Can you shed any light on getting a game like frozen-bubble to use
Alsa? When I try to start this app it lock up with error messages about
resources being busy.

   Am I correct in guessing that an app like frozen-bubble is using the
OSS portion of Alsa? Is there some setup that I can do to point OSS
sound requests to this default device?

Thanks much,
Mark



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
