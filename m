From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001617]: "The field ipc_gid must be a valid group (create group audio)"
Date: Sun, 4 Dec 2005 09:01:39 +0100
Message-ID: <b91e5f6a10178452119cb5ef7919f01e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71FBA16F
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2005 09:01:39 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1617> 
======================================================================
Reported By:                db1802xx
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1617
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-04-2005 09:01 CET
Last Modified:              12-04-2005 09:01 CET
======================================================================
Summary:                    "The field ipc_gid must be a valid group (create
group audio)"
Description: 
After upgrading alsa packages a while ago, i got some problems...
I'm not sure if this has to du with the alsa upgrade, or if it's something
else.. Only thing I'm sure of is that it worked the last time I used
mplayer with alsa(3 months ago, or something/with last version of
alsa-libs)..

As user in group "audio" I can use alsamixer, xmms and bmp...
But when i try to run aplay, mplayer I get this message:
   "The field ipc_gid must be a valid group (create group audio)"
  ALSA Lib: something about pcm_dmix.c line 1102 or something.......
There is no error when running as root...

I've recently changed from devfs to udev, so I have been trying to change
the permissions, groups and so on, but with no luck... 

Finaly i opend the "pcm_dmix.c" file in the source, and commented away a
few things to check if it would work if i forced it to skip the gid
check:

		if (strcmp(id, "ipc_gid") == 0) {
			char *group;
			char *endp;
			err = snd_config_get_ascii(n, &group);
			if (err < 0) {
				SNDERR("The field ipc_gid must be a valid group");
				return err;
			}
			//if (isdigit(*group) == 0) {
			//	struct group *grp = getgrnam(group);
			//	if (grp == NULL) {
			//		SNDERR("The field ipc_gid must be a valid group (create group %s)",
group);
			//		free(group);
			//		return -EINVAL;
			//	}
			//	ipc_gid = grp->gr_gid;
			//} else {
				ipc_perm = strtol(group, &endp, 10);
			//}
			free(group);
			continue;

After this everything works fine...

The question is:
Is this a ALSA related question (as in I've fucked up somthing in my OS),
or has this something to do with the latest alsa-lib(1.3.3)?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-04-05 09:01 db1802xx       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
