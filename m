From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: Re: new ALSA driver for audio on the ARM PXA2xx
	platform
Date: Wed, 26 Jan 2005 15:43:26 +0000
Message-ID: <1106754206.3998.1680.camel@cearnarfon>
References: <Pine.LNX.4.61.0501251624470.16341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0501251624470.16341@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Nicolas,

On Tue, 2005-01-25 at 21:33, Nicolas Pitre wrote:
> This patch adds two modules: one for generic PCM support on PXA2xx and 
> another to interface with the AC97 link on the PXA2xx.  Eventually 
> additional modules could be written to use the PCM module with SSP or 
> I2S audio ports.

Patch applied cleanly to 2.6.11-rc2, but is missing
include/asm-arm/arch-pxa/audio.h

Btw, I'll shortly be able to test with I2S and PCM codecs and I already
have some changes for AC97 support. (I'll send them after I know they
work)

Liam




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
