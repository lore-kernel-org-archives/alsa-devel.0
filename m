From: Ankhit Vivekananda <ankhit.vivekananda@biscotti.com>
Subject: Getting ICS43432 MEMS mic working with TMS320DM365
	processor
Date: Tue, 20 Oct 2015 09:37:19 -0500
Message-ID: <CACaQK7C8V9G5EFoxpTaDcF38zbU=OqErsd8YksbH=0OThCbydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CCB82665C7
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 16:37:20 +0200 (CEST)
Received: by wicfv8 with SMTP id fv8so32054084wic.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 07:37:19 -0700 (PDT)
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

Hello,

I have configured the TM320DM365 McBSP with clock and frame synchronization
signals. Also see the ICS43432 MIC serial data on the oscilloscope, but do
not get the right output in my application.

I have mapped the DaVinci McBSP with the CQ0093VC audio codec driver.
Is this mapping correct or is it necessary to map the McBSP with ICS-43432
codec driver?
Since, I have not applied the patch, I have used CQ0093VC codec driver.

Please do let me know if the ICS-43432 patch really necessary for the MIC
to work.

Thank you,
Ankhit
