From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Subject: Re: azx and PCI_DEVICE_ID_INTEL_ICH6_15
Date: Mon, 22 Nov 2004 23:24:29 +0100
Message-ID: <41A2671D.6000802@ens-lyon.fr>
References: <419F7E9F.6040807@ens-lyon.fr> <1100975509.6879.31.camel@krustophenia.net>
Reply-To: Brice.Goglin@ens-lyon.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100975509.6879.31.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell a écrit :
> On Sat, 2004-11-20 at 18:27 +0100, Brice Goglin wrote:
> 
>>Hi,
>>
>>We have a machine here whose lspci shows this soundcard :
>>
>>0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
>>Definition Audio Controller (rev 03)
> 
> 
> Sorry I missed the 'HD Audio' part.  I think you want the 'azx' driver:
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=8912810
> 
> AFAIK Intel posted this driver and it was committed to CVS but we have
> no user feedback yet.  So it should be considered experimental, though
> it should work.  It would be good to know how it works...
> 
> Lee

Hi,

We just gave it a try and it works!

alsamixer only sees five buttons (master, line, cd, mic and capture) but 
I don't care :)

Thanks a lot guys, hope this driver will go into the mainline kernel soon :)

Brice Goglin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
