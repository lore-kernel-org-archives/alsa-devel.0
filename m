From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: About the matrix control...
Date: 10 Apr 2003 21:30:15 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050010218.1636.20.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


>> About the matrix control, what did you decide ?
> it's accessed via normal control API.
> you can create "duplicated" entries by specifying the count field for
> snd_kcontrol_new_t.  for each duplicated entry, only the volatile part
> is created uniquely, which is accessed via ctl->vd[index].

I can't think of any use of ->vd... Inside callbacks do I get the
control number by kcontrol->index ?  Ok, but why ?  It was much simpler
to make struct sndrv_ctl_elem_value.value.integer.value[] larger or put
data in .value_ptr-> . What am I missing ?

Bye.




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
