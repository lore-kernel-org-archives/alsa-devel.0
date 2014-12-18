From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 4/6] ARM: mvebu: remove conflicting muxing on Armada 370 DB
Date: Thu, 18 Dec 2014 19:13:03 +0100
Message-ID: <5493192F.8060004@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141107031542.GB3698@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141107031542.GB3698@titan.lakedaemon.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Tawfik Bayouk <tawfik@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>, Nadav Haklai <nadavh@marvell.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Jason,

On 07/11/2014 04:15, Jason Cooper wrote:
> On Tue, Oct 28, 2014 at 05:08:42PM +0100, Thomas Petazzoni wrote:
>> Back when audio was enabled, the muxing of some MPP pins was causing
>> problems. However, since commit fea038ed55ae ("ARM: mvebu: Add proper
>> pin muxing on the Armada 370 DB board"), those problematic MPP pins
>> have been assigned a proper muxing for the Ethernet interfaces. This
>> proper muxing is now conflicting with the hog pins muxing that had
>> been added as part of 249f3822509b ("ARM: mvebu: add audio support to
>> Armada 370 DB").
>>
>> Therefore, this commit simply removes the hog pins muxing, which
>> solves a warning a boot time due to the conflicting muxing
>> requirements.
>>
>> Fixes: fea038ed55ae ("ARM: mvebu: Add proper pin muxing on the Armada 370 DB board")
>> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-370-db.dts | 24 ------------------------
>>  1 file changed, 24 deletions(-)
> 
> Patches 5 and 6 applied to mvebu/dt with Andrew's Ack.
> 
> I didn't Cc this one to stable since it is only removing a warning.

Actually it didn't just remove a warning. As explained with the patch
I sent yesterday: "[PATCH] ARM: mvebu: Fix pinctrl configuration for
Armada 370 DB", it also allows to use the first Ethernet Giga port on
the Armada 370 DB board.

> Later on, if needed, someone can request it be backported and the Fixes
> tag will assist with that.

Thanks for you offer and indeed I am not sure on how to do it, so your
help will be appreciate :)

I thought that I could forward to stable the patch sent by Thomas. I also thought
that adding the commit id used in linus tree and why we need it should be enough. Am
I right?

For 3.18 it seemed doable, but the bug on the Ethernet port was
introduced by the commit 49f3822509b74f8c8d0731aeb7ccea065376c9b ("ARM:
mvebu: add audio support to Armada 370 DB" in 3.14.")

So this patch won't be enough we also need the one sent by Ezequiel:
fea038ed55ae ("ARM: mvebu: Add proper pin muxing on the Armada 370 DB
board"). Then in this case I would have to add the line:

Cc: <stable@vger.kernel.org> # 3.14.x: fea038ed55ae ARM: mvebu: Add
proper pin muxing on the Armada 370 DB board


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
