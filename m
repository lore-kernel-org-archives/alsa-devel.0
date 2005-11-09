From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001533]: the *_bit routines are broken for systems with sizeof(long) != 4
Date: Wed, 9 Nov 2005 08:42:09 +0100
Message-ID: <d7551f1c1d5464b5a6ccc71665fa4b45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 272301CC
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 08:42:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1533> 
======================================================================
Reported By:                Hugh
Assigned To:                tiwai
======================================================================
Project:                    ALSA - tools
Issue ID:                   1533
Category:                   ld10k1
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             11-07-2005 22:02 CET
Last Modified:              11-09-2005 08:42 CET
======================================================================
Summary:                    the *_bit routines are broken for systems with
sizeof(long) != 4
Description: 
These problems were discovered by reading the code.  No testing has been
done.  The code in question is in
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-tools/ld10k1/src/bitops.h?rev=1.2&view=log

I have made a number of fixes to the code.  Please find attached the new
version.  Of course you should be wary of untested code.  Do read it and
understand what I've done and why this fixes several bugs.

CHANGES:

 The shift right of nr to calculate the subscript of addr
 was by sizeof(long) + 1.  The correct amount to shift by would be
 log2(sizeof(unsigned long) * 8).  It is awkward to calculate this
 value in a compile-time constant.
 Since gcc is smart enough to implement division or remainder of
 an unsigned by a power-of-two constant using shift or mask,
 I changed the code to use these clearer operations.

 Each parameter "nr" changed from int to unsigned.
 This more correctly reflects the fact that it must not be negative.
 (If it were supposed to allow negative numbers, it ought to have been
 of type ptrdiff_t since int might not work in systems where
 sizeof(int) < sizeof(void *).)
 It makes bitwise operations on nr more sensible.
 It allows the compiler to convert division-by-power-of-2 to shift.

 Each local variable "mask" changed from int to unsigned long.
 This matches the type of *addr, with which it will be combined.
 This prevents overflow when it is computed.

 Each assignment to mask was done with "1" shifted left.
 This needs to be done in unsigned long, so "1UL" is now used.

 Add "const" to type of *addr int test_bit (not a bug fix).

 Fixed the comments to be accurate.

======================================================================

----------------------------------------------------------------------
 tiwai - 11-08-05 18:27 
----------------------------------------------------------------------
Oh, I overlooked the patch.
Anyway, it's fixed on CVS now as smilarly as yours.  Thanks.

----------------------------------------------------------------------
 Hugh - 11-09-05 08:42 
----------------------------------------------------------------------
Thanks for responding to my submission.  I'm sorry that I didn't test and
hence glad that you (tiwai) are taking responsibility :-)

The use of division in the incrementing of "addr" is probably not
efficient unless the type of "nr" is changed to unsigned (as in my
version).  The reason is that division by a power of two is not the same
as shifting when the dividend is negative.  If gcc uses shift, that is a
bug in gcc (or it is using range analysis to show that nr can never be
negative; I did that, but it isn't trivial for a compiler to do so).

Once you use division of "nr" in calculating the increment of "addr", you
should probably use remainder (%) in calculating "mask".  This makes the
code more symmetric and clear in my opinion.

The comments at the front of the file seem misleading.  I redid them in
the version I submitted.

So do have a look again at what I submitted.

Thanks again.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-07-05 22:02 Hugh           New Issue                                    
11-07-05 22:02 Hugh           File Added: bitops.h                         
11-07-05 22:05 Hugh           Issue Monitored: Hugh                        
11-08-05 18:27 tiwai          Status                   new => resolved     
11-08-05 18:27 tiwai          Resolution               open => fixed       
11-08-05 18:27 tiwai          Assigned To               => tiwai           
11-08-05 18:27 tiwai          Note Added: 0006630                          
11-09-05 08:42 Hugh           Status                   resolved => feedback
11-09-05 08:42 Hugh           Resolution               fixed => reopened   
11-09-05 08:42 Hugh           Note Added: 0006644                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
