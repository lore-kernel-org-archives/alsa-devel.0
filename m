From: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Subject: Re: dsnoop, dshare and dmix plugins
Date: Thu, 20 Mar 2003 10:02:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048150926.3e79838e48c08@albert.homedns.org>
References: <Pine.LNX.4.44.0303191801460.1351-100000@pnote.perex-int.cz>
	<1048107111.8198.45.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048107111.8198.45.camel@cmn37.Stanford.EDU>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I think the documentation library used to mention the usage of dmix, but since the last update, I can't find it anymore (normally : http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html)

The code mentions :
This plugin provides direct mixing of multiple streams. The resolution
for 32-bit mixing is only 24-bit. The low significant byte is filled with
zeros. The extra 8 bits are used for the saturation.

pcm.name {
type dmix# Direct mix
ipc_key INT# unique IPC key
ipc_key_add_uid BOOL# add current uid to unique IPC key
slave STR
# or
slave {# Slave definition
pcm STR# slave PCM name
# or
pcm { }# slave PCM definition
format STR# format definition
rate INT# rate definition
channels INT
period_time INT# in usec
# or
period_size INT# in bytes
buffer_time INT# in usec
# or
buffer_size INT # in bytes
periods INT# when buffer_size or buffer_time is not specified
}
bindings {# note: this is client independent!!!
N INT# maps slave channel to client channel N
}
}

I wonder how you know that the number you assign is not in use...

IPC stands for Inter-Process communication. I've never used it though...

Look at http://users.actcom.co.il/~choo/lupg/tutorials/multi-process/multi-process.html for more info

Cheers,

Kristof


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
