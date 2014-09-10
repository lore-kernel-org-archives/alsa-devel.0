From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH 0/5] Add Phytec pbab01 audio support
Date: Wed, 10 Sep 2014 16:46:44 +0300
Message-ID: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
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
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawn.guo@freescale.com, kernel@pengutronix.de, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, timur@tabi.org, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, grant.likely@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patchset implements audio support on Phytec's phyFLEX-i.MX6
boards. This includes creating imx-tlv320aic3x machine driver, fixing
tlv320aic3x driver playback speed issue and enabling audio for pbab01
itself.
