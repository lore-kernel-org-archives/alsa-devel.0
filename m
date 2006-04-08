From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Full duplex mode
Date: Sat, 08 Apr 2006 10:16:11 -0400
Message-ID: <1144505771.5040.29.camel@localhost.localdomain>
References: <443720D4.2000905@kenati.com>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <443720D4.2000905@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-04-07 at 19:32 -0700, Carlos Munoz wrote:
> Hi all,
> 
> An alsa driver I've written supports full duplex mode (playback and 
> capture simultaneously). Do I need to anything special to support full 
> duplex mode ? I assume the playback_open(), etc and capture_open(), etc 
> will both get called and from the driver point of view I'm just handling 
> two streams, right ?

more or less correct. it depends on how you intend to manage
synchronization between the two streams within your application.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
