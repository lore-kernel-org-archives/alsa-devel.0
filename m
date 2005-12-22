From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Setting up Alsa by hand on an embedded system
Date: Thu, 22 Dec 2005 16:26:13 +0100
Message-ID: <20051222152613.GA6625@stud.ntnu.no>
References: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <b15982770512211736m71edba7eyc4885b0c3cd6bd93@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2005 at 07:36:06PM -0600, David Smoot wrote:
> [...]
> So I started by compiling some of the simple test programs, specifically the
> ones from the LinuxJournal article on ALSA (
> http://www.linuxjournal.com/article/6735).  

You noticed the comment about the bug in some of the listings?  The 
variable "dir" must be initialized to zero, or segfaults may occur.

Asbj.S.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
