From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [ardour-dev] Re: Tascam US-224/428 MMC: Work in
     progress...
Date: Wed, 28 Jul 2004 21:03:40 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32930.192.168.1.5.1091045020.squirrel@192.168.1.5>
References: Your message of "Wed, 28 Jul 2004 17:24:37 BST."            
    <63176.195.245.190.93.1091031877.squirrel@195.245.190.93>
    <200407281653.i6SGrMZn032601@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200407281653.i6SGrMZn032601@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, ardour-dev <ardour-dev@lists.ardour.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Paul, everyone,

>
>>I guess that's most likely due to something as a race condition between
>>ardour and us428control: by turning the jog wheel a MMC-Locate command
>
> I have no experience of wheels that send Locate. The wheel on the d8b
> sends either Shuttle or Step commands. I have no idea how a wheel that
> sends Locate is supposed to work, for precisely the reason you mention.
>

Shame on me. As a matter of fact, I've have no experience either, at all
:) It seems that my MMC jog wheel implementation is most probably a
complete mistake. I'm an idiot, spank me ;)

I'll try the MMC-Step/Shuttle route instead of that miserable MMC-Locate
wheel hack.

Stay tuned...
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
