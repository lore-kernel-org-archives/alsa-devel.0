From: Frank Barknecht <fbar@footils.org>
Subject: Re: alsa-lib resamplers broken.
Date: Wed, 17 Dec 2003 17:25:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031217162521.GA6157@fliwatut.scifi>
References: <3FE07BE6.5010100@superbug.demon.co.uk> <Pine.LNX.4.58.0312171653350.8959@pnote.perex-int.cz> <3FE08119.6030002@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3FE08119.6030002@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
James Courtier-Dutton hat gesagt: // James Courtier-Dutton wrote:

> Ooh! Interesting. So it is only a "plug" device, if it has "plug:" 
> before it. So the following are all non-plug devices?
> "front", "rear", "center-lfe", "surround40", "surround51" etc.
> 
> Plug devices: -
> dmix, dsnoop and anything with "plug:" before it.

To be correct: "dmix" is not a plug device, but "plug:dmix" is.  You
can see the exact definitions with 

$ aplay -L 2>&1 | less

For example, normally "default" is defined to be a plug device:

 default {
        type plug # <<< plug!
        slave.pcm {
 ...
 }

Also "plughw" is one, "plug" of course and everything, that has "type
plug" in it.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
