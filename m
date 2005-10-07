From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC - Clean up of ALSA kernel codes
Date: Fri, 7 Oct 2005 09:16:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0510070914310.8709@tm8103.perex-int.cz>
References: <20051006205140.76619.qmail@web60813.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051006205140.76619.qmail@web60813.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tsw@johana.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 6 Oct 2005, Tom Watson wrote:

> In your message you mentioned:
> "8. Clean up proc fs handlers".
> 
> My only idea is to make the /proc stuff a little more "page friendly".  
> Many of the register dumps are one register per line.  It is a bit 
> easier (in my opinion) to have them say 8 register values per line.  It 

I don't agree here. We have a lot text utilities (grep, awk etc.) which 
can be used to filter the registers for which one looks for. Having them 
mixed on one line means more mess (and you need the datasheet to check 
offsets by hand).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
