From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0001763]: How to provide patch for the soundcard matrix ?
Date: Mon, 23 Jan 2006 05:19:34 +0100
Message-ID: <a6c3e09939615c40a3acd00af9b0f256@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FFBE143
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2006 05:19:34 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1763> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   1763
Category:                   soundcard matrix
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-20-2006 09:10 CET
Last Modified:              01-23-2006 05:19 CET
======================================================================
Summary:                    How to provide patch for the soundcard matrix ?
Description: 
How to provide patch for the soundcard matrix ?

http://www.alsa-project.org/alsa-doc/index.php?vendor=All#matrix

(e.g. Is there any description of the xml file submitted in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=938 ? )

1) Is mpu401 uart regarded as [MIDIio] ?

2) Is coaxial SPDIF in/out regarded as [RCAio] ?

3) Is optical SPDIF out classified as [TOSo] ?

4) Add "modem not support" to Note


======================================================================

----------------------------------------------------------------------
 pochini - 01-22-06 17:34 
----------------------------------------------------------------------
Docs is here: http://www.alsa-project.org/alsa-doc/cards/README

The source file of soundcard entry is in /cards directory. For example the
source of:

http://alsa-project.org/alsa-doc/index.php?vendor=vendor-Echo_Corporation

is

http://alsa-project.org/alsa-doc/cards/vendor-Echo_Corporation

----------------------------------------------------------------------
 Raymond - 01-23-06 05:19 
----------------------------------------------------------------------
The validate CSS link at the bottom at sound card matrix

W3C CSS Validator Results for http://www.alsa-project.org/alsa-doc/

To work as intended, your CSS style sheet needs a correct document parse
tree. This means you should use valid HTML.
Errors
URI : http://www.alsa-project.org/alsa-doc/

    * Line: 127

      Invalid number : top only 0 can be a length. You must put an unit
after your number : 40
    * Line: 127

      Invalid number : left only 0 can be a length. You must put an unit
after your number : 120

Warnings
URI : http://www.alsa-project.org/components/alsa.css

    * Line : 6 (Level : 1) You have no background-color with your color :
A:link
    * Line : 7 (Level : 1) You have no background-color with your color :
A:visited
    * Line : 26 (Level : 2) Redefinition of margin-left :
#docsOverviewColumn1
    * Line : 26 (Level : 2) Redefinition of margin-bottom :
#docsOverviewColumn1
    * Line : 26 (Level : 2) Redefinition of margin-right :
#docsOverviewColumn1
    * Line : 26 (Level : 2) Redefinition of margin-top :
#docsOverviewColumn1
    * Line : 31 (Level : 1) You have no background-color with your color :
#docsOverviewColumn1 h3
    * Line : 49 (Level : 2) Redefinition of margin-bottom :
#docsOverviewColumn2
    * Line : 49 (Level : 2) Redefinition of margin-left :
#docsOverviewColumn2
    * Line : 49 (Level : 2) Redefinition of margin-right :
#docsOverviewColumn2
    * Line : 49 (Level : 2) Redefinition of margin-top :
#docsOverviewColumn2
    * Line : 54 (Level : 1) You have no background-color with your color :
#docsOverviewColumn2 h3
    * Line : 72 (Level : 2) Redefinition of margin-bottom :
#docsOverviewColumn3
    * Line : 72 (Level : 2) Redefinition of margin-left :
#docsOverviewColumn3
    * Line : 72 (Level : 2) Redefinition of margin-right :
#docsOverviewColumn3
    * Line : 72 (Level : 2) Redefinition of margin-top :
#docsOverviewColumn3
    * Line : 77 (Level : 1) You have no background-color with your color :
#docsOverviewColumn3 h3
    * Line : 121 (Level : 1) You have no background-color with your color
: #content h3
    * Line : 128 (Level : 1) You have no background-color with your color
: #content h4
    * Line : 142 (Level : 1) You have no background-color with your color
: #contentLinks h2
    * Line : 151 (Level : 1) You have no background-color with your color
: h2
    * Line : 160 (Level : 1) You have no background-color with your color
: h3
    * Line : 169 (Level : 1) You have no background-color with your color
: h4
    * Line : 194 (Level : 1) You have no color with your background-color
: #sideMenu
    * Line : 201 (Level : 2) Redefinition of margin-bottom : #sideMenu
ul#sideMenu2
    * Line : 201 (Level : 2) Redefinition of margin-left : #sideMenu
ul#sideMenu2
    * Line : 201 (Level : 2) Redefinition of margin-right : #sideMenu
ul#sideMenu2
    * Line : 201 (Level : 2) Redefinition of margin-top : #sideMenu
ul#sideMenu2
    * Line : 230 (Level : 2) Redefinition of width : #footer
    * Line : 262 (Level : 2) Redefinition of width : #ContentRight
    * Line : 264 (Level : 2) Redefinition of border-left-style :
#ContentRight
    * Line : 264 (Level : 2) Redefinition of border-top-style :
#ContentRight
    * Line : 264 (Level : 2) Redefinition of border-bottom-style :
#ContentRight
    * Line : 264 (Level : 2) Redefinition of border-right-style :
#ContentRight
    * Line : 273 (Level : 2) Redefinition of width : #ContentRelease
    * Line : 275 (Level : 2) Redefinition of border-bottom-style :
#ContentRelease
    * Line : 275 (Level : 2) Redefinition of border-top-style :
#ContentRelease
    * Line : 275 (Level : 2) Redefinition of border-right-style :
#ContentRelease
    * Line : 275 (Level : 2) Redefinition of border-left-style :
#ContentRelease
    * Line : 279 (Level : 1) You have no color with your background-color
: #ContentRelease
    * Line : 298 (Level : 2) Redefinition of width : #ContentRelease li
    * Line : 315 (Level : 2) Redefinition of width : #ContentRelease h3
    * Line : 322 (Level : 2) Redefinition of width : #Releases
    * Line : 324 (Level : 2) Redefinition of height : #Releases
    * Line : 329 (Level : 1) You have no color with your background-color
: #Releases
    * Line : 364 (Level : 2) Redefinition of width : #ContentNews

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-20-06 09:10 Raymond        New Issue                                    
01-22-06 17:34 pochini        Note Added: 0007749                          
01-23-06 05:19 Raymond        Note Added: 0007759                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
