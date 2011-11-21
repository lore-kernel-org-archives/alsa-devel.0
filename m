From: Sayem Ahmed <sayem64@gmail.com>
Subject: Re: Opening a PCM device in shared mode
Date: Mon, 21 Nov 2011 17:11:54 +0600
Message-ID: <4ECA31FA.60002@gmail.com>
References: <4EC8C046.4030706@gmail.com>
	<C516192DA6D2B74F8192CDC209D958FD5834F34861@dr-mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5631924465
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 12:12:07 +0100 (CET)
Received: by faaa20 with SMTP id a20so6129916faa.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 03:12:07 -0800 (PST)
In-Reply-To: <C516192DA6D2B74F8192CDC209D958FD5834F34861@dr-mail>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders Gnistrup <agn@datarespons.dk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Anders,

Thanks for your reply. I have created a /*.asoundrc*/ file in my home 
directory as you suggested and added the following configuration there 
(as you can see, these are basically the exact default configuration 
that the dmix plugin has) -

     pcm.lol
    {
         type dmix
         ipc_key 1024
         ipc_key_add_uid true
         slave {
             pcm "hw:0,0"
             period_time 125000
             rate 48000
             format S32_LE
             channels 2
         }
     }

Now when I start my program while a media player is running, it doesn't 
show any /*Device or Resource busy */error. It successfully opens the 
device and starts to write the sine wave into it. But the problem is I 
can't hear its output. I should have heard two sounds simultaneously but 
I can only hear the song in the media player, not the output sound from 
the example program. Similar things happens when I start the example 
first and the start a media player, I can only hear sounds from the 
first one.

Also, when I try to run the example program on different rate (i.e., 
rate 8000, channel 1) it throws an error saying format doesn't match. I 
guess it's because of the configuration rate that I specified in the 
file. I tried to supply multiple values for rate using array notations ( 
rate [8000, 48000] ) but it threw an error telling that the /*.asoundrc 
*/file is corrupted or old.

Actually the whole point of my exploration is this - I want to display a 
list of available audio cards/devices in my system to my application 
user who will then select the input and output audio card to 
record/playback audio data accordingly.

Thank you.


Regards,
Sayem Ahmed


On 11/21/2011 01:41 PM, Anders Gnistrup wrote:
> Hi Sayem
>
> It's because you open the device plughw:0,0.
> It's actually the device hw:0,0 with a additional "plug" pluggin. The plug pluggin takes care of resampling.
> Devices is not mixing device by design. This is handled by plugins (the dmix plugin)
>
> What you want is a device that can mix (and possible resample). For that you need a new virtual device.
> I have had the same problem myself, and the solution I have used is a .asoundrc configuration.
>
> pcm.mydmix
> {
>      type dmix
>      ipc_key 1024
>      slave {
>          pcm "hw:0,0"
>          period_time 0
>          period_size 1024
>          buffer_size 8192
>          rate 44100
> 	format "S32_LE"
>      }
> }
>
> Instead of the slave definition you could make your own. Now the device mydmix can be used as a mixing device.
>
