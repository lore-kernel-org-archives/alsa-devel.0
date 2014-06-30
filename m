From: Josh Lehan <alsa@krellan.com>
Subject: [PATCH - alsa-utils 4/5] Documentation manual page for
	amidicat
Date: Mon, 30 Jun 2014 01:55:02 -0700
Message-ID: <1404118503-22921-5-git-send-email-alsa@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1404118503-22921-1-git-send-email-alsa@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Josh Lehan <alsa@krellan.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Josh Lehan <alsa@krellan.com>

diff --git a/amidicat/amidicat.1 b/amidicat/amidicat.1
new file mode 100644
index 0000000..168a8b9
--- /dev/null
+++ b/amidicat/amidicat.1
@@ -0,0 +1,392 @@
+'\" t
+.\"     Title: amidicat
+.\"    Author: Josh Lehan <amidicat@krellan.com>
+.\" Generator: DocBook XSL Stylesheets v1.75.2 <http://docbook.sf.net/>
+.\"      Date: 2014-06-29
+.\"    Manual: amidicat
+.\"    Source: amidicat
+.\"  Language: English
+.\"
+.TH "AMIDICAT" "1" "2014-06-29" "amidicat" "amidicat"
+.\" -----------------------------------------------------------------
+.\" * set default formatting
+.\" -----------------------------------------------------------------
+.\" disable hyphenation
+.nh
+.\" disable justification (adjust text to left margin only)
+.ad l
+.\" -----------------------------------------------------------------
+.\" * MAIN CONTENT STARTS HERE *
+.\" -----------------------------------------------------------------
+.SH "NAME"
+amidicat \- Hooks up standard input and standard output to the ALSA MIDI
+sequencer
+.SH "SYNOPSIS"
+.HP \w'\fBamidicat\fR\ 'u
+\fBamidicat\fR [\-\-help] [\-\-version] [\-\-list] [\-\-name\ \fISTRING\fR]
+[\-\-port\ \fICLIENT:PORT\fR] [\-\-addr\ \fICLIENT:PORT\fR] [\-\-hex]
+[\-\-verbose] [\-\-nowrite] [\-\-noread] [\-\-delay\ \fIMILLISECONDS\fR]
+[\-\-wait\ \fISECONDS\fR] [file...]
+.SH "ARGUMENTS"
+.PP
+All of the following arguments are optional:
+.PP
+\fB\-\-help\fR
+.RS 4
+Displays a help screen, then exits\&.
+It is a quick summary of the
+documentation you are now reading\&.
+.RE
+.PP
+\fB\-\-version\fR
+.RS 4
+Displays version number, then exits\&.
+.RE
+.PP
+\fB\-\-list\fR
+.RS 4
+Shows a listing of all ALSA MIDI sequencer devices currently available
+for use, then exits\&.
+.sp
+Devices are displayed one per line, containing ALSA port
+number (CLIENT:PORT syntax), client name, port name, and flags\&.
+The flags are:
+.PP
+r
+.RS 4
+Device can be directly read from
+.RE
+.PP
+w
+.RS 4
+Device can be directly written to
+.RE
+.PP
+R
+.RS 4
+Device can be read from, either directly or via ALSA read subscription
+.RE
+.PP
+W
+.RS 4
+Device can be written to, either directly or via ALSA write subscription
+.RE
+.RE
+.PP
+\fB\-\-name \fR\fB\fISTRING\fR\fR
+.RS 4
+Sets the client name of this program\'s ALSA connection\&.
+This might be helpful to identify the amidicat port number,
+when using other applications\&.
+.sp
+The effects of setting this option can be observed in the
+\fB\-\-list\fR
+output\&. The default client name is
+\(lqamidicat\(rq\&.
+.RE
+.PP
+\fB\-\-port \fR\fB\fICLIENT:PORT\fR\fR, \fB\-\-addr \fR\fB\fICLIENT:PORT\fR\fR
+.RS 4
+Makes a direct connection to the given ALSA port number,
+for reading and writing\&.
+If this option is not given,
+the default is to only set up a passive connection
+for use with the ALSA subscription mechanism\&.
+.sp
+The parameter is either a numeric
+\fICLIENT:PORT\fR
+(example:
+128:0), or the client name or port name of another program\'s ALSA
+connection (use the
+\fB\-\-list\fR
+option to see what is available)\&.
+If the name contains spaces, remember to put it in quotes\&.
+.sp
+The
+\fB\-\-port\fR
+and
+\fB\-\-addr\fR
+options are identical\&.
+For syntax compatibility with other ALSA programs,
+you have the choice of using either,
+but only one of these options may be given\&.
+.RE
+.PP
+\fB\-\-hex\fR
+.RS 4
+Changes the syntax of input and output,
+to be human\-readable hex digits,
+optionally separated by whitespace\&.
+This option applies to all input files\&.
+If this option is not given, the default is raw binary data\&.
+.sp
+Hex digits must be in the range
+0
+through
+9,
+A
+through
+F, or
+a
+through
+f\&. Bytes are optionally separated by whitespace\&.
+If whitespace is not given, every two hex digits represent a byte\&.
+An error happens if input is not a hex digit or whitespace\&.
+.sp
+With this option, the MIDI output data will be grouped\&.
+Each MIDI event will be separated by a newline character,
+but each individual byte within the event will only be separated by a space\&.
+This makes it easy to observe the individual MIDI events\&.
+.RE
+.PP
+\fB\-\-verbose\fR
+.RS 4
+Provides additional output, on standard error\&.
+This option is highly recommended\&.
+.sp
+Among other useful things,
+it displays this program\'s ALSA port number,
+once the connection to ALSA is made\&.
+So, if you start another ALSA program afterwards,
+with the intention of connecting to this program,
+you will know what port number to use\&.
+.RE
+.PP
+\fB\-\-nowrite\fR
+.RS 4
+Disables writing data into ALSA from standard input\&.
+When this option is used,
+no input files may be given on the command line\&.
+.sp
+The intent of this option is to allow a read\-only connection to devices
+that do not give write permission\&.
+These devices can be identified in the
+\fB\-\-list\fR
+output, as they do not have the
+\fBw\fR
+or
+\fBW\fR
+flags\&.
+.RE
+.PP
+\fB\-\-noread\fR
+.RS 4
+Disables reading data out of ALSA to standard output\&.
+This option can not be combined with the
+\fB\-\-nowrite\fR
+option\&.
+.sp
+The intent of this option is to allow a write\-only connection
+to devices that do not give read permission\&.
+These devices can be identified in the
+\fB\-\-list\fR
+output, as they do not have the
+\fBr\fR
+or
+\fBR\fR
+flags\&.
+.RE
+.PP
+\fB\-\-delay\fR \fIMILLISECONDS\fR
+.RS 4
+Inserts a delay,
+in milliseconds,
+ between each MIDI event written to ALSA from input\&.
+.sp
+This is useful for avoiding event loss due to ALSA queue congestion\&.
+Although this program tries to avoid overflowing ALSA\'s internal buffer,
+events will still be lost if they arrive too quickly\&.
+Unlike other MIDI programs,
+this program does not take any tempo or other timing information
+at all into account,
+and will write data into ALSA as quickly as it is read from input\&.
+So, when using this program,
+event overflow is highly likely,
+unless this option is used\&.
+.sp
+This option will slow down the processing of input\&.
+A value of 10 milliseconds is usually sufficient to avoid event loss\&.
+When using the
+\fB\-\-verbose\fR
+option,
+total counts of events processed will be output when this program exits,
+so these counters can be used to verify that no events were lost\&.
+.RE
+.PP
+\fB\-\-wait\fR \fISECONDS\fR
+.RS 4
+After all input has finished being processed,
+continue running this program for the given number of seconds,
+then exit\&. This option can not be combined with the
+\fB\-\-nowrite\fR
+option\&.
+.sp
+Unless this option is given,
+this program will exit immediately after completing all
+input\&. This includes processing all input files,
+and reaching EOF on standard input, if standard input is being used\&.
+.sp
+This option is useful for allowing some additional time
+for MIDI data to be received from ALSA\&.
+For example, this might be useful for sending MIDI commands to a synthesizer,
+and then waiting for any responses to come back\&.
+.RE
+.PP
+Everything else on the command line is interpreted as
+the filename of an input file\&.
+The special filename
+\-
+represents standard input\&.
+Filenames are processed left to right,
+so this can be used to insert other files before or after standard input\&.
+If no filenames are given on the command line,
+standard input is the default\&.
+.SH "DESCRIPTION"
+.PP
+\fBamidicat\fR
+hooks up standard input and standard output to the ALSA MIDI sequencer\&.
+Like
+\fBcat\fR(1),
+this program will concatenate multiple input files together\&.
+.SH "EXAMPLES"
+.PP
+All of these examples use the
+\fBTiMidity\fR
+software synthesizer\&. Change the
+\fB\-\-port "TiMidity"\fR
+parameter to use anything else you have\&.
+\fBTiMidity\fR does not provide read permission to ALSA,
+so the
+\fB\-\-noread\fR
+parameter is required.
+If you are using a real hardware synthesizer,
+you can omit the
+\fB\-\-noread\fR
+parameter\&.
+Use caution when trying the examples
+that generate random data or play arbitrary files,
+as they could send unwanted SysEx commands\&.
+.PP
+\fBExample\ \&1.\ \&List all ALSA sequencer devices\fR
+.PP
+\fBamidicat \-l\fR
+.PP
+This will list all MIDI devices on your system
+that are visible to the ALSA sequencer\&.
+Here is sample output:
+.sp
+.if n \{\
+.RS 4
+.\}
+.nf
+ Port    Client name                      Port name                        rwRW
+  0:0    System                           Timer                            rwR-
+  0:1    System                           Announce                         r-R-
+ 14:0    Midi Through                     Midi Through Port-0              rwRW
+ 15:0    OSS sequencer                    Receiver                         -w--
+128:0    TiMidity                         TiMidity port 0                  -w-W
+128:1    TiMidity                         TiMidity port 1                  -w-W
+128:2    TiMidity                         TiMidity port 2                  -w-W
+128:3    TiMidity                         TiMidity port 3                  -w-W
+129:0    Virtual Keyboard                 Virtual Keyboard                 r-R-
+130:0    amidicat                         amidicat                         rwRW
+.fi
+.if n \{\
+.RE
+.\}
+.sp
+.PP
+\fBExample\ \&2.\ \&Play MIDI files very quickly\fR
+.PP
+\fBamidicat \-\-port "TiMidity" \-\-noread \-\-delay 10 *\&.mid\fR
+.PP
+This will play all MIDI files in the current directory very quickly,
+without regard for tempo\&. The
+\&.mid
+file format will not be recognized,
+so headers and other information will play as garbage\&.
+This would be more useful for files containing nothing but raw MIDI data,
+perhaps SysEx commands that you wish to load into a hardware synth\&.
+.PP
+\fBExample\ \&3.\ \&A better "beep" command\fR
+.PP
+\fBecho "903C7F" | amidicat \-\-port "TiMidity" \-\-noread \-\-hex\fR
+.PP
+This plays Middle C\&.
+It\'s easy to elaborate on this\&.
+If you have an application that makes many beeps,
+replacing the beeps with MIDI can make it more pleasant\-sounding\&.
+.PP
+\fBExample\ \&4.\ \&Transport MIDI data over the network\fR
+.PP
+\fBnc \-v \-l \-p 12345 | amidicat \-\-port "TiMidity" \-\-noread\fR
+.PP
+This command sets up a server listening on port 12345\&.
+Now, from somewhere else on the Internet, use
+\fBnc\fR
+to connect to port 12345 of this machine running
+\fBamidicat\fR, and start sending it MIDI data\&. It should play\&.
+.PP
+\fBExample\ \&5.\ \&View MIDI notes being played in real time\fR
+.PP
+\fBamidicat \-\-verbose \-\-hex\fR
+.PP
+\fBvkeybd \-\-addr 128:0\fR
+.PP
+After
+\fBamidicat\fR
+starts up, replace the \-\-addr argument of this example
+\fBvkeybd\fR
+command, to match what is displayed by
+\fBamidicat\fR, if it is different\&.
+When \fBvkeybd\fR appears,
+notes played on its virtual keyboard should be displayed on
+\fBamidicat\fR
+standard output\&.
+The bytes of each MIDI command will be displayed,
+one per line\&.
+.PP
+\fBExample\ \&6.\ \&Stress-test your softsynth by playing random data\fR
+.PP
+\fBcat /dev/urandom | amidicat \-\-port "TiMidity" \-\-noread \-\-delay 1\fR
+.PP
+Turn down your speakers before trying this\&. The
+delay
+parameter is necessary to avoid flooding ALSA with a deluge of random data\&.
+Do not use this with a real hardware synthesizer,
+or you could damage your settings if, by bad luck,
+a random SysEx command is formed!
+Hit Control\-C to stop the program,
+and you might get to hear a rather interesting sound effect
+that was caused by playing random data\&.
+.PP
+\fBExample\ \&7.\ \&Panic button\fR
+.PP
+\fBperl \-e \'for($i=0;$i<16;$i++){print
+pack('C3',176+$i,120,0);}\' | amidicat \-\-port "TiMidity"
+\-\-noread\fR
+.PP
+This Perl one\-liner sends MIDI "All Sound Off" commands to every channel\&.
+It should silence all audio currently being played\&.
+You will want to use this command after playing the stress\-test above :)
+.PP
+\fBExample\ \&8.\ \&Another panic button\fR
+.PP
+\fBperl \-e \'for($i=0;$i<16;$i++){for($j=0;$j<128;$j++){print
+pack('C3',128+$i,$j,127);}}\' | amidicat \-\-port "TiMidity"
+\-\-noread\fR
+.PP
+Another Perl one\-liner, which sends all individual "Note Off" commands\&.
+It is slower than the above,
+but perhaps useful for an older synth that doesn\'t
+understand the "All Sound Off" command\&.
+.SH "SEE ALSO"
+.PP
+\fBamidi\fR(1),
+\fBaconnect\fR(1)
+.SH "AUTHOR"
+.PP
+\fBJoshua Lehan\fR <\&alsa@krellan\&.com\&>
+.RS 4
+Author
+.RE
-- 
1.8.3.2
