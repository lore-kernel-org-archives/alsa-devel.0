From: Nick Arnold <nick.arnold@nautronix.com.au>
Subject: patch for HDSP 9652
Date: Thu, 9 Oct 2003 11:04:07 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031009110407.A5188@nautronix.com.au>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I'm following-up regarding the patch to hdsp.c + changes to hdsp.h that
Thomas Charbonnel sent me late August.  The patch fixed some unexplained
signal on the output channels of the card, and was for ALSA 0.9.6.

It appears that this patch has not been integrated with 0.9.7a release of
ALSA.  When installing the new version we get the same symptom observed prior
to applying the patch (unexplained signal output on several channels).  We've
also tried applying the original patch and it no longer applies cleanly to
hdsp.c.

Not sure what the status of things are, so:

    - has the patch been applied to the ALSA tree?
    - alternatively, is there a new version of the patch that will apply
      cleanly to the 0.9.7a release?

thanks much for your help,

nick.
--
This email is confidential and intended solely for the use of the individual to whom it is addressed.  Any views or opinions presented are solely those of the author and do not necessarily represent those of Nautronix Ltd.

If you are not the intended recipient, you have received this email in error and use, dissemination, forwarding, printing, or copying of this email is strictly prohibited.  If you have received this email in error please contact the sender.

Although our computer systems use active virus protection software, and we take various measures to reduce the risk of viruses being transmitted in e-mail messages and attachments sent from this company, we cannot guarantee that such
e-mail messages and attachments are free from viruses on receipt.  It is a condition of our using e-mail to correspond with you, that any and all liability on our part arising directly or indirectly out of any virus is excluded.
Please ensure that you run virus checking software on all e-mail messages and attachments before reading them.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
