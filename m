From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: snd_mixer_gid_t??
Date: Mon, 02 Aug 2004 18:10:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410E759D.803@superbug.demon.co.uk>
References: <51BF576D5A02CC4CB2591F50994FD76691CBDB@nts013.uk.trt.thales>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <51BF576D5A02CC4CB2591F50994FD76691CBDB@nts013.uk.trt.thales>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Yong, Chee Yeew " <Chee-Yeew.Yong@thalesgroup.com>
Cc: alsa-user@lists.sourceforge.net, "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Yong, Chee Yeew wrote:
> Hello,
> 
> Does anyone know in which library is the "snd_mixer_gid_t" struct located?
> 
> I tried to install a program that utilises the soundcard, and during
> compilation it is complaining that it does not know what a "snd_mixer_gid_t"
> type is. The only references that I have found on the web regarding
> snd_mixer_gid_t is alsa. 
> 
> Does anyone know how to fix the program? Should I be including other
> libraries?
> 
> Thank you!
> 
> C
> 

snd_mixer_gid_t is not used by alsa any more.

What is the application you are trying to install.
It probably needs upgrading to the latest alsa api.

James



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
