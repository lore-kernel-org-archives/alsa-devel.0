From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: hdsp patch, version II
Date: Wed, 05 Mar 2003 09:41:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18qa33-0005gb-00@sc8-sf-list1.sourceforge.net>
References: <1046874063.1458.15.camel@satellite.undata.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "05 Mar 2003 15:21:03 +0100."
             <1046874063.1458.15.camel@satellite.undata.org>
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

>> OK, so this means that 
>> 
>>     hdsp_fifo_wait (hdsp, 0, some_count);
>> 
>> is waiting till the FIFO is empty. by contrast, 
>> 
>>     hdsp_fifo_wait (hdsp, 127, some_count);
>> 
>> waits till there is 1 word available in the FIFO, meaning that we can
>> write to it.
>> 
>How is that we can write to it if it is full ?

we never test for it being full. the tests are either for <= 0 (EMPTY)
or <= 127 (at least 1 word available).

>In the case the above question is stupid, and the fifo being full
>meaning we can write to it, we have the following code in
>snd_hdsp_initialize_firmware anyway:
>
>for (i = 0; i < 24413; ++i) {
>	hdsp_write(hdsp, HDSP_fifoData, firmware_ptr[i]);
>	if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
>		snd_printk ("timeout during firmware loading\n");
>		return -EIO;
>	}
>}

yes, but before we enter that loop we checked to make sure that the
FIFO was empty. so the loop is really writing a word, then waiting for
a word to be available.

>> this doesn't help explain why we sometimes fail to see this condition
>> being met. any insights?
>
>Is it really that the condition is not being met ?
>It should gracefully fail. That's what timeouts are for. If the
>condition fails, then the driver should fail to instantiate, and the
>boot process should go on. The problem is that we have a freeze.

i agree. i can't see why it doesn't, unless the LONG_WAIT delays us
for so long that it looks like a freeze ...

--p


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
