From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Access of 2 RME Multifaces
Date: Tue, 13 Apr 2004 16:01:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407C00E0.60000@wildgooses.com>
References: <20040412114457.GA1511@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040412114457.GA1511@finnendahl.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Orm Finnendahl wrote:

>Hi,
>
>hope this is the right list to post: I installed to RME Pci Cards with
>a Multiface each. Running hdsploader finds and initializes both and
>hdspmixer can also get used with both cards using the card select
>buttons for card1 and card2. However after startup of jack, I only see
>18 alsa_pcm in and out ports instead of 36.
>
>Can someone point me to some infos regarding where and how to
>configure that? I guess it has to be done somewhere in alsa, but I
>might be wrong...
>
>  
>

I think Jack can only use one output device?  There is a "hack" which 
should work on pro cards like the rme where you can create a virtual 
card which binds the two individual cards together.  You will need to 
use the wordclock or otherwise sync the two cards though

See the alsa wiki for details (hint it involves writing a customer 
asoundrc file)

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
