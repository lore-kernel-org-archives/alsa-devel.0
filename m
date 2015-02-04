From: "Tim E. Real" <termtech@rogers.com>
Subject: Single vs. multiple seq client ports
Date: Tue, 03 Feb 2015 19:44:26 -0500
Message-ID: <11961012.AHGMH1UnbJ@col-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1-vm3.access.bullet.mail.bf1.yahoo.com
 (nm1-vm3.access.bullet.mail.bf1.yahoo.com [216.109.114.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 54C272604F8
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 01:44:37 +0100 (CET)
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

Hi. Our app currently uses a single alsa midi seq client port
 to address all external midi ports.

I have an opportunity now to change this to allow as many
 client ports as desired, for example one client port for each 
 external port found.

If I proceed, it is possible the user may have many client ports
 if desired.

What are the advantages and disadvantages if any, in terms 
 of speed and resources, of having a single client port versus 
 multiple client ports?

Thanks.
Tim.
