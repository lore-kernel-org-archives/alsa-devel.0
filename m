From: Mardy <mardy@users.sourceforge.net>
Subject: Re: [Application] OPL3 with hwdep
Date: Sun, 12 Jan 2003 20:55:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030112195515.GA2254@pupilla>
References: <20030112190151.GA2057@pupilla> <Pine.LNX.4.33.0301122010400.611-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301122010400.611-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 12, 2003 at 08:12:53PM +0100, Jaroslav Kysela wrote:
> On Sun, 12 Jan 2003, Mardy wrote:
> 
> > I want to make a simple OPL3 beeper, but I'm stuck with
> > snd_hwdep_open(), I just don't know what string I should call it with.
> 
> hw:# (where # is your card number or string identification), it is usually 
> 'hw:0'; or the more simple way is to pass 'default' string as hwdep name

Tried both, but I still get a -2.
I'm using Debian woody (libasound2 0.9.0beta10a-3).

-- 
Saluti,
    Mardy
http://castellina.org/interlingua


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
