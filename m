From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: [PATCH 1/2] Xlinx ML403 AC97 Controller Reference device driver
Date: Thu, 9 Aug 2007 11:17:11 -0700
Message-ID: <20070809181713.77B24708062@mail66-cpk.bigfish.com>
References: <1186655810.7420.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
Content-class: urn:content-classes:message
In-Reply-To: <1186655810.7420.26.camel@localhost>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: =?iso-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>, linuxppc-embedded@ozlabs.org
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

 
I second grant here... this should eventually work on microblaze, too,
so putting it drivers/ and using XILINX_DRIVERS instead of XILINX_VIRTEX
(based on the patch Wolfgang recently posted) would probably be preferable.

> +
> +config SND_ML403_AC97CR
> +       tristate "Xilinx ML403 AC97 Controller Reference"
> +       depends on SND && XILINX_VIRTEX

Steve
