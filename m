From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000953]: corrupted file in alsa-driver CVS
Date: Wed, 2 Mar 2005 14:20:25 +0100
Message-ID: <f570e52e1ab9e17dfe553ec677eb69f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 92ED51F3
	for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2005 14:20:25 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=953> 
======================================================================
Reported By:                Wummel
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   953
Category:                   OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             03-01-2005 12:05 CET
Last Modified:              03-02-2005 14:20 CET
======================================================================
Summary:                    corrupted file in alsa-driver CVS
Description: 
When running cvs2cl command, I get the following error:
cvs log: Logging kernel
cvs [log aborted]: unrecognized operation '\x9' in
/cvsroot/alsa/alsa-driver/kernel/Attic/mixer.c,v
Problem reading log input (pid/exit/signal/core: 32710/1/0/0)

I think the mentioned file is corrupted (as suggested while googling for
this error).
======================================================================

----------------------------------------------------------------------
 Wummel - 03-01-05 12:06 
----------------------------------------------------------------------
The web interface also gives a traceback:
http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-driver/kernel/Attic/mixer.c?rev=1.89&view=log

Traceback (most recent call last):
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/viewcvs.py", line 2730, in
main
    request.run_viewcvs()
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/viewcvs.py", line 353, in
run_viewcvs
    self.view_func(self)
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/viewcvs.py", line 1591, in
view_log
    show_revs = request.repos.filelog(request.path_parts, rev, options)
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/vclib/bincvs/__init__.py",
line 193, in filelog
    filtered_revs = _file_log(revs, tags, default_branch, rev)
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/vclib/bincvs/__init__.py",
line 703, in _file_log
    taginfo['HEAD'] = _add_tag('HEAD', taginfo['MAIN'].co_rev)
  File "/usr/local/viewcvs-pre-1.0-sf.net/lib/vclib/bincvs/__init__.py",
line 373, in _add_tag
    tag = Tag(tag_name, revision.string)
AttributeError: 'NoneType' object has no attribute 'string'

----------------------------------------------------------------------
 perex - 03-02-05 14:20 
----------------------------------------------------------------------
Yes, this corruption has caused probably an older version of CVS server. As
far as I know, it cannot be fixed (maybe, we can remove this file from CVS
manually). Skip this file..

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-05 12:05 Wummel         New Issue                                    
03-01-05 12:06 Wummel         Note Added: 0003759                          
03-02-05 14:20 perex          Status                   new => resolved     
03-02-05 14:20 perex          Resolution               open => won't fix   
03-02-05 14:20 perex          Assigned To               => perex           
03-02-05 14:20 perex          Note Added: 0003775                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
