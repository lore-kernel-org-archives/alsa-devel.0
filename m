From: Thomas Rabe <raven@drehmoment.org>
Subject: Re: questions about usbmidi
Date: Thu, 10 Apr 2003 20:18:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E95B581.3050605@drehmoment.org>
References: <Pine.HPX.4.33n.0304101733100.4735-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0304101733100.4735-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>>Clemens Ladisch wrote:
> 
> So the oops isn't related to USB at all.
> 
> The first thing after outputting "created ... ports" is the line:
> 
> 	list_add(&umidi->list, &umidi->chip->midi_list);
> 
> It may be possible that your US428 driver doesn't initialize
> chip->midi_list. This may indicate that you didn't merge all the changes
> made to usbaudio.c.

uh, sorry. i forgot the INIT_LIST_HEAD(&us428(card)->chip.midi_list) 
call. now midi works and everything is fine:) thanks!


> HTH
> Clemens




Greetings,

Thomas Rabe.



-- mail: raven at drehmoment dot org
-- home: http://hal9000.drehmoment.org
-- more: http://drehmoment.org



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
