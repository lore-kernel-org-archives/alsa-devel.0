From: Brad Midgley <bmidgley@xmission.com>
Subject: Re: alsa-lib plugin devel
Date: Mon, 24 Jan 2005 13:08:25 -0700
Message-ID: <41F555B9.3040608@xmission.com>
References: <Pine.HPX.4.33n.0501240933490.4480-100000@studcom.urz.uni-halle.de>	<41F522DE.30702@xmission.com>	<s5hk6q2u659.wl@alsa2.suse.de>	<1106585584.8058.61.camel@pegasus>	<s5hhdl6u52n.wl@alsa2.suse.de>	<1106587386.8058.69.camel@pegasus> <s5hmzuyend9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzuyend9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi

> Agreed, I/O plugin can set itself as the list candidate.
> 
> 
>> In the case of a2dp the option
>>"type a2dp" should result in asking the plugin if its devices (or maybe
>>this device) are listed or not. An additional option looks for me like
>>over-configuration.
> 
> 
> Well, I think it's useful to have this as an option, too.
> If you have your own favorite configuration, you can add it to the
> list of supported devices.
> The attribute should be off as default, of course.

This sounds great. It's your project, so I shouldn't jump in and do it 
but let me know if you do want me to get in there. As long as you intend 
to make this change, it makes the plugin development worthwhile from my 
perspective. :)

One question... will the client need to change how they query for 
devices? How much latitude do you have while keeping the api stable?

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
