From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp patch, version II
Date: 05 Mar 2003 17:54:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046883274.1421.23.camel@satellite.undata.org>
References: <E18qboi-0006vC-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18qboi-0006vC-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-03-05 at 17:34, Paul Davis wrote:

> 
> eh? if it returns any non-zero value, we return from
> hdsp_initialize_firmware() with -EIO, surely?

You're perfectly right, sorry, I've been mixing things up... :)
I guess a reason for it was that getting all those snd_printks from
hdsp_fifo_wait sounded like having hdsp_fifo_wait being called from a
loop.
Do you have any clue I could work on ?

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
