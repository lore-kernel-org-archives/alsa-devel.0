From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: ALSA docs
Date: Fri, 26 Jul 2002 02:51:16 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D403A94.2070308@boosthardware.com>
References: <E17XlTw-00041v-00@usw-sf-list1.sourceforge.net> <3D402F7D.3010405@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm looking into ways to automate the modules options component file for 
  the docs.

At the moment I am considering using perl or mysql. Does anyone know 
which is easier to setup to do the following.

Parse the INSTALL file for a module name.
Return the info for that module.

Then either

Write the module info to a temp file which is inserted into the template

  or

insert the module info into the template.

The problem with mysql is that I would need access to the database. The 
good thing is that it wouldn't have to get the info everytime a webpage 
was accessed only when the info changed. (I think)


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
