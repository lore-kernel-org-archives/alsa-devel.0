From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: DMIX and capture stream
Date: Wed, 7 Jan 2004 13:05:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040107130530.4dd7edf6.mista.tapas@gmx.net>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
	<200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>
	<s5h1xqe2rjp.wl@alsa2.suse.de>
	<Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>
	<20040106223828.39d2c233.mista.tapas@gmx.net>
	<s5hvfno10r5.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfno10r5.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 07 Jan 2004 12:01:02 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> as written in my previous mail, it was a quick hack.  and there is a
> better approach.
> 
> the attached patch will add a new plugin, asym, which defines
> different slave pcms for playback and capture streams.
> for example,
> 
> 	pcm.duplex {
> 		type asym
> 		playback.pcm "dmix"
> 		capture.pcm "dsnoop"
> 	}
> 

Ah, ok. This solution makes even more sense, since it is more generally
useful. Especially for [broken] alsa apps that don't let you specify
seperate pcm's for playback/capture..

I think of this plugin as making a full duplex pcm out of two half
duplex pcm. So why not call the plugin "duplexer"?

Flo

P.S.: One question that comes up though: What happens when you specify a
full duplex device as one of the two pcm's? Will there be an error msg?
Or maybe some of the "multi" functionality could be used...

-- 
hrrrm! 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
