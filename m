From: Gary Jones <nightbreed@verizon.net>
Subject: alsa-tools/as10k1
Date: Mon, 3 Jan 2005 04:19:57 -0500
Message-ID: <200501030419.58228.nightbreed@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi

I am using Slackware 10 with Linux Kernel 2.6.10 and gcc 3.4.3-i686 and tried 
to compile as10k1 in alsa-tools from CVS 1.0.8-rc1.

Normally when I try to compile I receive the a parse error like so:
as10k1.c: 163: error: label at end of compound statement

from the 'parse_cli_args' function.

In order to get it to compile I had to change:
line 161. next_cli_args: in as10k1.c to next_cli_args:; <-- added the ; at the 
end. After that it compiled correctly.

I was wondering if this is a known issue or is it just me and I am missing 
something with a normal compile.

Regards


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
