From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Update: emu1212m
Date: Sun, 18 Jun 2006 10:14:12 +0100
Message-ID: <44951964.9020509@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

This is just a quick note to say that I have made some progress with the
alsa support for emu1212m.
Summary:
If one cold boots to windows, and then warm boots to linux, I have
managed to get SPDIF out working on the emu1212m.
This is good news, because I have managed to determine the final bit of
work required to get the emu1212m working in Linux.
The emu1212m has a FPGA on it.
1) The FPGA array is filled with the netlists.
2) The FPGA now has registers that can be read and written to switch
features on and off. E.g. spdif out or adat out.

Now, I have done a lot of the work for step 2. I just need to work out
how to do step 1 now.
Step 1 happens on cold boot, and survives a warm boot.
Step 2 is already understood in the Linux driver.

Summary:
TODO: Step 1.

James
