From: ziv haziz <ziv.haziz@dspg.com>
Subject: adding an external dsp under soc-dsp framework
Date: Mon, 6 Aug 2012 12:53:40 +0000 (UTC)
Message-ID: <loom.20120806T144411-583@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE2D265217
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 14:24:06 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SyMog-0001M1-V5
 for alsa-devel@alsa-project.org; Mon, 06 Aug 2012 14:53:51 +0200
Received: from proxy56.messagelabs.net ([85.158.138.25])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 14:53:50 +0200
Received: from ziv.haziz by proxy56.messagelabs.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 14:53:50 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i plan on adding an external dsp which has slimbus interface under soc-dsp 
framwork.
currently i would like to make the following type of connection:
CPU->DSP->Codec and as the dsp is an external one
(physically seperated from both the CPU and the Codec)
i have a difficulty defining how to represent it:
do i need to make two entities of the dsp:
- one for the BE connection and one for the FE connection 
and add some internal routing using mixer controls? this will 
create two devices in the user space which the user application should open? 
- or is there a way to make one device which is composed of all three blocks?

last small question: as slimbus ports id should be passed how do you suggest a 
device should share his slimbus port id?
