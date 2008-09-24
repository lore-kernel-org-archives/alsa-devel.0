From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hda_intel (sigmatel) defunct in mmotm
	2008-09-13-03-09
Date: Wed, 24 Sep 2008 11:42:21 +0200
Message-ID: <48DA0B7D.3060801@gmail.com>
References: <48CE6A90.1070309@gmail.com> <48CFC601.9050608@embeddedalley.com>
	<48D0C69D.4090105@gmail.com> <48D10F8F.5090703@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 0579F243C2
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 11:42:26 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so2103246fgg.44
	for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2008 02:42:26 -0700 (PDT)
In-Reply-To: <48D10F8F.5090703@embeddedalley.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthew Ranostay <mranostay@embeddedalley.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/17/2008 04:09 PM, Matthew Ranostay wrote:
> Jiri Slaby wrote:
>> On 09/16/2008 04:43 PM, Matthew Ranostay wrote:
>>> Bug fix patch at:
>>>
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-September/010767.html
>> It works, thanks.
> 
>> Another problem is when I switch IEC958 in alsamixer, I get:
> 
> 
> Ok, the problem was that codec->slave_dig_outs getting a dereference when NULL.
> This has been already fixed in Takashi's sound-2.6.git tree, with the commit id
> 06efc354f735d5dbbdf4653fc6a8acd489ac5a18.

ACKing this. Thanks.
