From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/3] EP93xx: Add i2s core support
Date: Tue, 8 Jun 2010 18:26:31 -0500
Message-ID: <0D753D10438DA54287A00B02708426976370DCDC51@AUSP01VMBX24.collaborationhost.net>
References: <1275991272-30122-1-git-send-email-ryan@bluewatersys.com>
	<1275991272-30122-2-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269763708AFD76@AUSP01VMBX24.collaborationhost.net>
	<4C0E9987.2010907@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C0E9987.2010907@bluewatersys.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "john.cooper@third-harmonic.com" <john.cooper@third-harmonic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "chasedouglas@gmail.com" <chasedouglas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "r&d4@dave-tech.it" <r&d4@dave-tech.it>, "dhuggins@cs.cmu.edu" <dhuggins@cs.cmu.edu>, "marshall@coolbananas.co.nz" <marshall@coolbananas.co.nz>, "buytenh@wantstofly.org" <buytenh@wantstofly.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday, June 08, 2010 12:27 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> On Tuesday, June 08, 2010 3:01 AM, Ryan Mallon wrote:
>>> Add core support for EP93xx i2s audio
>>>
>>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> Looks good.
>> 
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> 
>
> Okay, I have Liam and Hartley's acks on this one and Liam's on 3/3.
> Mark, do you want to apply the other two patches to your tree, or should
> they go via the arm tree?

Ryan,

It appears Mark doesn't see ant reason to apply patch 1 to his tree.  It's
probably better to send that one thru Russell's patch system in case any
other changes are made to the ep93xx core files.

Regards,
Hartley
