From: Brian Victor <bhv1@psu.edu>
Subject: General Guidelines?  (MIDI)
Date: Sat, 11 Jan 2003 13:31:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111183121.GA12653@bhv1.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Are there any documented guidelines on how to make use of ALSA
(especially MIDI) functions?  They seem to be designed with attention to
nomenclature, but I don't have a clear idea of when they're needed.

For example, when using ALSA data type foo, the standard seems to be to
call snd_seq_alloc_foo, manipulate foo as desired, then call
snd_seq_free_foo.  This is easy enough, but sometimes (as in the case of
queue), there is also a create function; how does this differ from
alloc, and is it necessary?

Also, what is the relationship between buffers and queues?  Is a queue
needed prior to buffering output?  Or do they serve completely different
functions?

Thanks in advance to anyone who can clear these things up for me.

-- 
Brian


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
