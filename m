From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: How do I make -D hw:0,1 default?
Date: Wed, 4 Jun 2003 01:30:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030604013014.255e4429.mista.tapas@gmx.net>
References: <NDBBLGIKBJENLAMOLFHGCEBCCGAB.mknecht@controlnet.com>
	<1054667178.2274.5.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1054667178.2274.5.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 03 Jun 2003 12:06:18 -0700
Mark Knecht <markknecht@attbi.com> wrote:

> Jaroslav,
>    This did not work for me. I made the edits to the .asoundrc file,
> tried aplay with and without the -D, then tried restarting alsa and
> tried aplay again. It didn't work.

hi..  maybe i can add something.. here's a snippet from my .asoundrc

pcm.!default {
        type hw
        card 0
}

ctl.!default {
        type hw
        card 0
}


this creates a "default" pcm device which can point to any kind of pcm
device.. here it refers to card 0 which is a hw device. maybe you cann
add a "device 1" or "subdevice 1" to make it use the right pcm..




-- 
horrible sound clips - http://www.arted.biz/mista.tapas
buggy software - http://rythmaidgui.sourceforge.net


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
