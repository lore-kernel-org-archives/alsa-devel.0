From: Petr Kulhavy <petr@barix.com>
Subject: [PATCH v5 0/4] ASoC: davinci-mcbsp: add binding for McBSP
Date: Mon,  9 May 2016 16:35:18 +0200
Message-ID: <1462804522-29544-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, brain@jikos.cz, Petr Kulhavy <petr@barix.com>, robh+dt@kernel.org, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This series of patches adds devicetree support for the davinci McBSP audio
interface.

Changes in version 5 of the patch:

* rebased to the current master of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
* independent changes submitted separately (3/7 and 7/7 of the version 4)
* 5/7 of the version 4 removed as already applied
* corrected mcbsp0 and mcbsp1 nodes in the DTS file: using correct address and sound@ prefix
