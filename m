From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [RFC][RFT] Adding support for Jazz16 based sound
 cards
Date: Mon, 19 Mar 2007 22:40:48 +0100
Message-ID: <45FF0360.9010006@gmail.com>
References: <20070311232436.GB9778@sygehus.dk> <45FDDA0F.7050503@gmail.com>
	<45FEFB4D.20108@gmail.com> <45FEFF19.4000805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45FEFF19.4000805@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 03/19/2007 10:22 PM, Rene Herman wrote:

Something definitely fishy with that sourceforge moderation interface. 
I'm obviously approving my own messages, but some still aren't making it:

> On 03/19/2007 10:06 PM, Rene Herman wrote:
> 
>> static void __devinit snd_jazz16_set_ports(u8 value)
>> {
>>         outb(SB_JAZZ16_WAKEUP, SB_JAZZ16_CONFIG_PORT);
>>         outb(SB_JAZZ16_SET_PORTS, SB_JAZZ16_CONFIG_PORT);
>>         outb(value, SB_JAZZ16_CONFIG_PORT);
>> }
> 
> bug -- can't be __devinit, since called from snd_jazz16_free.

Rene.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
