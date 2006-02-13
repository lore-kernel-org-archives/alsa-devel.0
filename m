From: Ron Cococcia <ron.cococcia@request.com>
Subject: Re: prealloc/buffer time limit?
Date: Mon, 13 Feb 2006 10:07:23 -0500
Message-ID: <43F0A0AB.3050102@request.com>
References: <43ED016D.9030301@request.com> <20060213080655.GA8896@ifiu25.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060213080655.GA8896@ifiu25.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

My apologies :)  I've been flipping between 2 different tasks, and 
flipped the symbol name.  I am referring to "prealloc_max_size", part of 
the ich_pcm_table struct for intel8x0.

Thanks and best regards,
Ron


Clemens Ladisch wrote:
> Ron Cococcia wrote:
> 
>>I went into the driver for the sound device (intel8x0), and noticed
>>the buffer_max being set to 128.  I modified the max values to 512k
> 
> 
> There is no buffer_max symbol.  What exactly did you change?
> 
> 
> Regards,
> Clemens



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
