From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch, version II
Date: Wed, 05 Mar 2003 11:34:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qboi-0006vC-00@sc8-sf-list1.sourceforge.net>
References: <1046880783.1421.8.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "05 Mar 2003 17:13:03 +0100."
             <1046880783.1421.8.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>On Wed, 2003-03-05 at 15:41, Paul Davis wrote:
>
>> i agree. i can't see why it doesn't, unless the LONG_WAIT delays us
>> for so long that it looks like a freeze ...
>
>It doesn't, as after hitting the magic sysrq sigterm sequence I can see
>the hdsp_fifo_wait's snd_printks appear on a regular basis (looks like
>120 bpm). This is not surprising as HDSP_LONG_WAIT is supposed to last
>500ms. In fact the timeout should occur  24413/2/60 = circa 186 minutes
>later. The code is :
>
>for (i = 0; i < 24413; ++i) {
>       hdsp_write(hdsp, HDSP_fifoData, firmware_ptr[i]);
>       if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
>               snd_printk ("timeout during firmware loading\n");
>               return -EIO;
>       }
>}
>
>If hdsp_fifo_wait fails and returns -1 we go through the whole loop,
>thus effectively waiting almost 3 hours.

eh? if it returns any non-zero value, we return from
hdsp_initialize_firmware() with -EIO, surely?

--p


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
