From: Ed Wildgoose <lists@wildgooses.com>
Subject: Re: Problem with RME 9632 and Plug
Date: Tue, 03 Aug 2004 16:44:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <410FB2EC.8010008@wildgooses.com>
References: <200408031436.i73EaLj2005332@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408031436.i73EaLj2005332@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:

>>I have had a long standing issue with mplayer not working with my RME 
>>9632.  I have at last finally tracked down part of the problem...
>>
>>It seems that the RME 9632 in conjunction with the plug device will only 
>>accept a value of 2 fragments/periods when using the 
>>    
>>
>
>what PCM device name are you using?
>  
>

Relevant bits of /etc/asound.conf

        pcm.rme9632plug {
                type plug
                slave {
                        pcm "rme9632"
                    }
        }
        ctl.rme9632plug {
                type hw
                card 1
        }


And it's this plug device that I am using.

Sorry, should have added this in the first message

Any ideas?

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
