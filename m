From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: [PATCH] 1/2 alsa-python: API coverage documentation
	tool
Date: Fri, 07 Mar 2008 22:47:25 -0300
Message-ID: <1204940845.6474.14.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WLiywQWfBiAijVBD6+hh"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id B305624543
	for <alsa-devel@alsa-project.org>; Sat,  8 Mar 2008 02:47:36 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so384211ana.80
	for <alsa-devel@alsa-project.org>; Fri, 07 Mar 2008 17:47:31 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-WLiywQWfBiAijVBD6+hh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

HG Log:
-------
Added python tool of alsa-lib C API coverage for alsa-python binding.


Description:
------------

The following patch is a python tool that shows how much of the
asoundlib API is being covered by the alsa-python binding. It works by
parsing the C source code and comparing with the official Doxygen
documentation from alsa website.

It will help the following users:
- alsa-python developers: know how is mapped the original C API, so
which python function/variable may be used.
- python binding developers: know how much of the C API is covered. It
could help for mistakes (free() instead of using
snd_ctl_card_info_free), know what is missing, and statistic interest ;)



Sample output:
--------------

Functions
---------
1   const char* snd_asoundlib_version ( void )
        Returns the ALSA sound library version in ASCII format.
          => Used in    :     alsacard.c: asoundlib_version

Defines
-------
N/A #define SND_CONTROL_DLSYM_VERSION _dlsym_control_001
        dlsym version for interface entry callback
          **** NOT AVAILABLE/USED SND_CONTROL_DLSYM_VERSION ****
2   #define SND_CTL_ASYNC
        Async notification (flag for open mode)
          => As constant:  alsacontrol.c: open_mode["ASYNC"]
          => As constant: alsahcontrol.c: open_mode["ASYNC"]
1   #define snd_ctl_card_info_alloca ( ptr )
        allocate an invalid snd_ctl_card_info_t using standard alloca
          => Used in    :  alsacontrol.c: pyalsacontrol_cardinfo


Stats:
------

After every section, the program shows some stats about usage. This is
the current usage of each doxygen module:

Global defines and functions  
 16 missing ( 94%)   0 excluded (  0%) of  17 total (  6% covered).
Error handling                
  9 missing ( 90%)   0 excluded (  0%) of  10 total ( 10% covered).
Control Interface             
137 missing ( 53%)   0 excluded (  0%) of 257 total ( 47% covered).
High level Control Interface  
 21 missing ( 46%)   0 excluded (  0%) of  46 total ( 54% covered).
Setup Control Interface       
  4 missing (100%)   0 excluded (  0%) of   4 total (  0% covered).
MIDI Sequencer                
 25 missing ( 61%)   7 excluded ( 17%) of  41 total ( 39% covered).
Sequencer Client Interface    
 15 missing ( 35%)  14 excluded ( 33%) of  43 total ( 65% covered).
Sequencer Port Interface      
 48 missing ( 74%)   6 excluded (  9%) of  65 total ( 26% covered).
Sequencer Port Subscription   
  3 missing (  7%)  15 excluded ( 33%) of  46 total ( 93% covered).
Sequencer Queue Interface     
 58 missing ( 84%)   0 excluded (  0%) of  69 total ( 16% covered).
Sequencer Event API           
 42 missing ( 93%)   0 excluded (  0%) of  45 total (  7% covered).
Sequencer Miscellaneous       
  0 missing ( N/A)   0 excluded ( N/A) of   0 total ( N/A covered).
Sequencer Event Type Checks   
  7 missing ( 23%)   0 excluded (  0%) of  30 total ( 77% covered).
Sequencer Event Definitions   
 35 missing ( 40%)   0 excluded (  0%) of  87 total ( 60% covered).
Sequencer Middle Level Interfa
 38 missing ( 78%)   0 excluded (  0%) of  49 total ( 22% covered).
Sequencer event <-> MIDI byte 
 11 missing (100%)   0 excluded (  0%) of  11 total (  0% covered).
Mixer Interface               
 44 missing ( 75%)   0 excluded (  0%) of  59 total ( 25% covered).
Simple Mixer Interface        
 14 missing ( 18%)   0 excluded (  0%) of  78 total ( 82% covered).


Cheers!


-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>

--=-WLiywQWfBiAijVBD6+hh
Content-Disposition: attachment; filename=doc-alsa-python-coverage
Content-Type: text/x-patch; name=doc-alsa-python-coverage; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/doc/.hgignore b/doc/.hgignore
new file mode 100644
--- /dev/null
+++ b/doc/.hgignore
@@ -0,0 +1,3 @@
+syntax: glob
+
+cache/*
diff --git a/doc/APICoverage.py b/doc/APICoverage.py
new file mode 100644
--- /dev/null
+++ b/doc/APICoverage.py
@@ -0,0 +1,385 @@
+#! /usr/bin/python
+
+# APICoverage.py -- helper for API coverage tools
+# Copyright(C) 2008 by Aldrin Martoq <amartoq@dcc.uchile.cl>
+#  Licensed under GPL v2 (see below).
+#
+# Description:
+#    This file provides the base for creating an API coverage tool. It may
+#    be used in other projects, for an example see the coverage.py tool.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2 as
+#  published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+
+
+import os, pickle, urllib, sys
+from pyparsing import *
+from htmlentitydefs import entitydefs
+from htmllib import HTMLParser
+from formatter import AbstractFormatter, DumbWriter
+
+# cache dir (preparsed source and HTML asoundlib API)
+cache = 'cache'
+# directory of source code
+source_dir = '.'
+# base url
+api_url = ''
+# summary (section) counter
+summary_total = summary_miss = summary_exc = 0
+# subsection (defines, typedefs, etc) counter
+count_total = count_miss = count_exc = 0
+
+if not os.path.exists(cache):
+    print "Creating cache dir: %s" % cache
+    os.makedirs(cache)
+
+def read_source(name):
+    """ Reads the specified source file """
+    filename = os.path.join(source_dir, name)
+    return (name, "".join(open(filename).readlines()), filename)
+
+def list_to_str(alist):
+    tmp = []
+    for i in alist:
+        if type(i) is ParseResults:
+            tmp.append(list_to_str(i))
+        else:
+            tmp.append(str(i))
+    return tmp
+            
+
+def get_cached_parse(index_parser_list, name):
+    """
+    Generate the scan lists from the parsers, store it in a file in the
+    cachedir and return it; if the file already exists it just return it
+    without processing.
+    """
+    name = os.path.join(cache, name)
+
+    if os.path.exists(name):
+        modified = False
+        for source, parser in index_parser_list:
+            if os.stat(source[2]).st_mtime > os.stat(name).st_mtime:
+                modified = True
+        if not modified:
+            return pickle.load(open(name))
+
+    print "generating cache, file: %s" % name,
+    dict = {}
+    for source, parser in index_parser_list:
+        print source[0],
+        sys.stdout.flush()
+        list = []
+        for tokenlist, start, end in parser.scanString(source[1]):
+            tlist = list_to_str(tokenlist)
+            list.append((tlist, int(start), int(end)))
+        dict[source[0]] = list
+    pickle.dump(dict, open(name, "wb"))
+    print
+    return dict
+
+# API html parsing/caching
+
+def get_cached_api(url, name):
+    """
+    Download the HTML API from the specified url and stores it in a
+    file in the cachedir; if the file already exists it just returns it
+    contents.
+    """
+    name = os.path.join(cache, name)
+    if os.path.exists(name):
+        data = "".join(open(name).readlines())
+    else:
+        print "downloading %s" % url
+        data = urllib.urlopen(url).read()
+        open(name, "w").write(data)
+    return data
+
+
+
+class AsoundlibAPIHTMLParser(HTMLParser):
+    """
+    Customized HTMLParser, it adds some markers for easy parsing the
+    HTML asoundlib API from the alsa website.
+    """
+    
+    HTMLParser.entitydefs['nbsp'] = ' '
+    
+    def __init__(self, name, data):
+        f = AbstractFormatter(DumbWriter(open(name, 'w'), 100))
+        HTMLParser.__init__(self, f)
+        self.feed(data)
+        self.close()
+
+    def start_h1(self, attrs):
+        HTMLParser.start_h1(self, attrs)
+        self.handle_data("--- titlestart")
+        self.do_br(None)
+
+    def start_table(self, attrs):
+        if len(attrs) == 1 and attrs[0] == ("class", "memname"):
+            self.handle_data("--- itemstart")
+            self.do_br(None)
+
+    def start_tr(self, attrs):
+        self.do_br(None)
+
+    def anchor_end(self):
+        pass
+
+def parse_asoundlib_api(lines):
+    """
+    Parses an html file (given as a set of lines including '\n').
+    Returns a list of: title, defines, typedefs, enums, functions.
+    """
+    state = 0
+    defines = []
+    typedefs = []
+    enums = []
+    functions = []
+    current = None
+    title = None
+    name = ""
+    comment = ""
+    enumsublist = []
+    for line in lines:
+        line = line[:-1]
+        if False:
+            if id(current) == id(defines):
+                print "defines   ",
+            elif id(current) == id(typedefs):
+                print "typedefs  ",
+            elif id(current) == id(enums):
+                print "enums     ",
+            elif id(current) == id(functions):
+                print "functions ",
+            else:
+                print "          ",
+            print "%s %d %s" % (id(current), state, line)
+
+        if line.startswith('Define Documentation'):
+            current = defines
+            state = 0
+        elif line.startswith('Typedef Documentation'):
+            current = typedefs
+            state = 0
+        elif line.startswith('Enumeration Type Documentation'):
+            current = enums
+            state = 0
+        elif line.startswith('Function Documentation'):
+            current = functions
+            state = 0
+        elif line.startswith('--- itemstart'):
+            state = 1
+        elif line.startswith('--- titlestart'):
+            state = 5
+        elif state == 5:
+            title = line
+            state = 0
+        elif current == None:
+            continue
+        elif state == 1:
+            if line == "":
+                state = 2
+            else:
+                name += line
+        elif state == 2:
+            if id(current) == id(enums):
+                state = 3
+            else:
+                comment = line
+                current.append((name, comment))
+                name = ""
+                comment = ""
+                state = 0
+        elif state == 3 and line.startswith('Enumerator:'):
+            state = 4
+            enumsublist = []
+        elif state == 4:
+            if line == "":
+                current.append((name, comment, enumsublist))
+                name = ""
+                comment = ""
+                state = 0
+            else:
+                enum, subcomment = line.split(' ', 1)
+                enumsublist.append((enum, subcomment))
+
+    return (title, defines, typedefs, enums, functions)
+        
+
+def print_name(d0, d1, name, look_constant, look_usage, exclude_list):
+    """ 
+    Prints a defined entry (typedef, function, etc) and its usage to stdout.
+    It also updates counters ({summary,count}_{total,miss,exc}).
+
+    Parameters:
+      d0 -- entry prototype
+      d1 -- entry documentation (one liner)
+      name -- entry name (define, function name, etc)
+      look_constant -- lookup name for constant (a defined python function)
+      look_usage -- lookup name for usage (a defined python function)
+    """
+    global summary_total, summary_miss, summary_exc
+    global count_total, count_miss, count_exc
+    summary_total += 1
+    count_total += 1
+    lc = look_constant(name)
+    uc = look_usage(name)
+    usecount = len(lc) + len(uc)
+    exccount = 0
+    for token, comment in exclude_list:
+        if token == name:
+            exccount += 1
+    if usecount == 0:
+        if exccount > 0:
+            used = "EXC"
+            summary_exc += 1
+            count_exc += 1
+        else:
+            used = "N/A"
+            summary_miss += 1
+            count_miss += 1
+    else:
+        used = "%s" % usecount
+        
+    print "%-4s%s" % (used, d0)
+    print "%8s%s" % ("", d1)
+
+    if usecount > 0:
+        excstr = "Comment"
+    else:
+        excstr = "Excluded"
+    for token, comment in exclude_list:
+        if token == name:
+            print "%10s==> %11s: %s" % ("", excstr, comment)
+    for s in lc:
+        print "%10s=> As constant: %s" % ("", s)
+    for s in uc:
+        print "%10s=> Used in    : %s" % ("", s)
+    if used == "N/A":
+        print " "*10 + "**** NOT AVAILABLE/USED %s ****" % name
+
+
+def _print_stat(title, section, missing, excluded, total):
+    if total == 0:
+        fmissing = "N/A"
+        fexcluded = "N/A"
+        fcovered = "N/A"
+    else:
+        fmissing = (100*(float(missing)/float(total)))
+        fexcluded = (100*(float(excluded)/float(total)))
+        fcovered = 100 - fmissing
+        fmissing = "%3.0f%%" % fmissing
+        fexcluded = "%3.0f%%" % fexcluded
+        fcovered = "%3.0f%%" % fcovered
+    print "STAT %-30.30s %-12.12s: " % (title, section) + \
+        "%3d missing (%4s) %3d excluded (%4s) of %3d total (%4s covered)." % \
+        (missing, fmissing, excluded, fexcluded, total, fcovered)
+
+
+def print_stat(title, section):
+    """
+    Print STATS line for the given title and section. It will
+    reset the section counters (count_{total,miss}).
+    """
+    global count_total, count_miss, count_exc
+    _print_stat(title, section, count_miss, count_exc, count_total)
+    count_total = count_miss = count_exc = 0
+
+def print_summary_stat(title):
+    """
+    Print STATS line for the last given title and section. It will
+    reset the title summary counters (summary_{total,miss}).
+    """
+    global summary_total, summary_miss, summary_exc
+    _print_stat(title, "SUMMARY", summary_miss, summary_exc, summary_total)
+    summary_total = summary_miss = summary_exc = 0
+
+
+def parse_excludes(excludes):
+    list = []
+    for line in excludes.splitlines():
+        s = line.split(' ', 1)
+        if len(s) > 1:
+            token = s[0]
+            comment = s[1]
+            list.append((token, comment))
+    return list
+
+
+
+def print_api_coverage(urls, look_constant, look_usage, excludes):
+    
+    el = parse_excludes(excludes)
+
+    for url in urls:
+        data = get_cached_api(api_url + url, url)
+        tmp = os.path.join(cache, 'tmp')
+        AsoundlibAPIHTMLParser(tmp, data)
+        (title, defines, typedefs, enums, functions) = \
+            parse_asoundlib_api(open(tmp).readlines())
+        print title
+        print "="*len(title)
+        print "\n"*2
+        #print "%s\n%s\n%s\n%s\n%s\n\n" % \
+        #    (title, defines, typedefs, enums, functions)
+        summary_total = 0
+        summary_miss = 0
+        if len(defines) > 0:
+            print "Defines"
+            print "-------"
+            for d in defines:
+                name = d[0].split(' ')[1]
+                print_name(d[0], d[1], name, look_constant, look_usage, el)
+            print_stat(title, "Defines")
+            print "\n"*2
+        if len(typedefs) > 0:
+            print "Typedefs"
+            print "--------"
+            for d in typedefs:
+                names = d[0].split(' ')
+                name = names[-1]
+                if ')' in name:
+                    names = d[0].split('(')
+                    name = names[-2].split()[-1]
+                print_name(d[0], d[1], name, look_constant, look_usage, el)
+            print_stat(title, "Typedefs")
+            print "\n"*2
+        if len(enums) > 0:
+            print "Enumerations"
+            print "------------"
+            for e in enums:
+                print "%s" % e[0]
+                for d in e[2]:
+                    name = d[0]
+                    print_name(d[0], d[1], name, look_constant, look_usage, el)
+            print_stat(title, "Enumerations")
+            print "\n"*2
+        if len(functions) > 0:
+            print "Functions"
+            print "---------"
+            for d in functions:
+                name = None
+                for n in d[0].split(' '):
+                    if n.startswith('snd_'):
+                        name = n
+                    elif n.startswith('('):
+                        break
+                if name != None:
+                    print_name(d[0], d[1], name, look_constant, look_usage, el)
+            print_stat(title, "Functions")
+            print "\n"*2
+        print_summary_stat(title)
+        print "\n"*4
+
diff --git a/doc/alsa-python-coverage.py b/doc/alsa-python-coverage.py
new file mode 100755
--- /dev/null
+++ b/doc/alsa-python-coverage.py
@@ -0,0 +1,364 @@
+#! /usr/bin/python
+
+# coverage.py -- python coverage of asoundlib API
+# Copyright(C) 2008 by Aldrin Martoq <amartoq@dcc.uchile.cl>
+#  Licensed under GPL v2 (see below).
+#
+# Description:
+#    This tool aims to help in completing the python binding of the asoundlib
+#    API. Actually, it's being coded for the current pyalsa, but it can be
+#    easily modified to support other styles of codes (mainly by changing the
+#    pyparsing objects used to scan the source code).
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2 as
+#  published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+
+
+from APICoverage import *
+import APICoverage
+from pprint import pprint
+import time
+
+__author__ = "Aldrin Martoq <amartoq@dcc.uchile.cl>"
+__version__ = "1.0"
+__license__ = "GNU General Public License version 2"
+__copyright__ = "Copyright(C) 2008 by Aldrin Martoq <amartoq@dcc.uchile.cl>"
+
+
+# setup and do the work
+APICoverage.source_dir = '../pyalsa'
+APICoverage.api_url = 'http://www.alsa-project.org/alsa-doc/alsa-lib/'
+
+time_start = time.time()
+
+# common C parser
+ident = Word(alphas + "_", alphanums + "_")
+type_and_var = \
+    Optional(oneOf("const unsigned struct")) \
+    + ident + Optional(Word("*")) + ident
+args = OneOrMore(type_and_var) + ZeroOrMore("," + type_and_var)
+function_declaration = type_and_var + "(" + Group(args) + ")"
+function_define = \
+    "#define" + ident \
+    + "(" + OneOrMore(ident) + ZeroOrMore("," + ident) + Optional("...") + ")"
+function_define_block = \
+    "#define" + ident + "{"
+#    + Group(("(" + args + Optional("...") + ")") | "{")
+
+# common asoundlib parser
+snd_ = Regex("snd_[\w_]+")
+SND_ = Regex("SND_[\w_]+")
+
+# pyalsa/alsaseq.c parser
+alsaseq_SEQ = Regex("SEQ_[\w_]+")
+alsaseq_Constant = \
+    "TCONSTADD(module," + alsaseq_SEQ + "," + quotedString + "," + alsaseq_SEQ
+alsaseq_typedef = \
+    Literal("typedef") \
+    + "struct" \
+    + "{" \
+    + "PyObject_HEAD" \
+    + Optional(";") \
+    + OneOrMore((type_and_var + ";") | cppStyleComment) \
+    + "}" \
+    + ident.setName("struct_name")
+alsaseq_function = \
+    "static" \
+    + function_declaration.setName("static_function")
+alsaseq_index = function_define | function_define_block \
+    | alsaseq_typedef | alsaseq_function
+
+# pyalsa/{alsacard, alsacontrol, alsahcontrol, alsamixer}.c parser
+addspace = Regex("add_space[0-9]")
+addspace_def = \
+    Suppress(addspace + "(") \
+    + quotedString + Suppress(",") + ident + Suppress(");")
+alsaall_Constant = \
+    Suppress(Literal("#define") \
+    + addspace \
+    + "(pname, name) { \\" \
+    + "o = PyInt_FromLong(") \
+    + SND_ \
+    + Suppress("##name); \\") \
+    + Suppress("PyDict_SetItemString(d1, pname, o); \\") \
+    + Suppress("Py_DECREF(o); }") \
+    + OneOrMore(Group(addspace_def)) \
+    + Suppress("PyDict_SetItemString(d,") \
+    + quotedString
+
+
+
+alsaall_typedef = \
+    Literal("struct") \
+    + "{" \
+    + "PyObject_HEAD" \
+    + Optional(";") \
+    + OneOrMore((type_and_var + ";") | cppStyleComment) \
+    + "}"
+alsaall_function = \
+    "static" \
+    + function_declaration.setName("static_function")
+alsaall_index = function_define | alsaall_typedef | alsaall_function
+
+# read all files
+pyalsaseq = read_source('alsaseq.c')
+pyalsacard = read_source('alsacard.c')
+pyalsacontrol = read_source('alsacontrol.c')
+pyalsahcontrol = read_source('alsahcontrol.c')
+pyalsamixer = read_source('alsamixer.c')
+
+# parse all files with parser
+index = get_cached_parse([
+        (pyalsaseq, alsaseq_index),
+        (pyalsacard, alsaall_index),
+        (pyalsacontrol, alsaall_index),
+        (pyalsahcontrol, alsaall_index),
+        (pyalsamixer, alsaall_index)
+        ], "index")
+index_snd_ = get_cached_parse([
+        (pyalsaseq, snd_),
+        (pyalsacard, snd_),
+        (pyalsacontrol, snd_),
+        (pyalsahcontrol, snd_),
+        (pyalsamixer, snd_)
+        ], "index_snd_")
+index_SND_ = get_cached_parse([
+        (pyalsaseq, SND_),
+        (pyalsacard, SND_),
+        (pyalsacontrol, SND_),
+        (pyalsahcontrol, SND_),
+        (pyalsamixer, SND_)
+        ], "index_SND_")
+index_Constant_alsaseq = get_cached_parse([
+        (pyalsaseq, alsaseq_Constant)
+        ], "index_Constant_alsaseq")
+index_Constant_alsaall = get_cached_parse([
+        (pyalsacard, alsaall_Constant),
+        (pyalsacontrol, alsaall_Constant),
+        (pyalsahcontrol, alsaall_Constant),
+        (pyalsamixer, alsaall_Constant)
+        ], "index_Constant_alsaall")
+
+# urls of doxygen documentation
+urls = [
+    # globals
+    "group___global.html",
+    # error handling
+    "group___error.html",
+    # control
+    "group___control.html",
+    "group___h_control.html",
+    "group___s_control.html",
+    # sequencer
+    "group___sequencer.html",
+    "group___seq_client.html",
+    "group___seq_port.html",
+    "group___seq_subscribe.html",
+    "group___seq_queue.html",
+    "group___seq_event.html",
+    "group___seq_misc.html",
+    "group___seq_ev_type.html",
+    "group___seq_events.html",
+    "group___seq_middle.html",
+    "group___m_i_d_i___event.html",
+    # mixer
+    "group___mixer.html",
+    "group___simple_mixer.html"
+    ]
+
+def look_constant(name):
+    """
+    Look name for constant declarations.
+    
+    Returns:
+      a list of strings with the file and python constant.
+    """
+    nlist = []
+    for file in index_Constant_alsaseq:
+        for lc in index_Constant_alsaseq[file]:
+            tokens, start, end = lc
+            rs = "SND_" + tokens[5]
+            if rs == name:
+                nlist.append("%14s: %s" % (file, tokens[5]))
+                nlist.append("%14s: %s[%s]" % 
+                              (file, tokens[1].lower(), tokens[3]))
+    for file in index_Constant_alsaall:
+        for lc in index_Constant_alsaall[file]:
+            tokens, start, end = lc
+            prefix = tokens[0]
+            dictname = tokens[-1].split('"')[1]
+            for i in range(1, len(tokens)-1):
+                rs = prefix + tokens[i][1]
+                if rs == name:
+                    nlist.append("%14s: %s[%s]" %
+                                 (file, dictname, tokens[i][0]))
+
+    return nlist
+
+def look_usage(name):
+    """
+    Look name for usage (appareance) in C functions, structs, etc.
+
+    Returns:
+      a list of strings with the file and matched function/struct/define.
+    """
+    name = name.strip()
+    dict = {}
+    for file in index_snd_:
+        list = []
+        for lu in index_snd_[file]:
+            tokens, start, end = lu
+            rs = tokens[0]
+            if rs == name:
+                list.append(start)
+        dict[file] = list
+    for file in index_SND_:
+        list = []
+        for lu in index_SND_[file]:
+            tokens, start, end = lu
+            rs = tokens[0]
+            if rs == name:
+                list.append(start)
+        if dict.has_key(file):
+            dict[file].extend(list)
+        else:
+            dict[file] = list
+
+    nlist = []
+    for file in dict:
+        for lstart in dict[file]:
+            if not index.has_key(file):
+                continue
+            found = None
+            previous = None
+            for call in index[file]:
+                tokens, start, end = call
+                if start > lstart:
+                    found = previous
+                    break
+                previous = tokens[2]
+                if tokens[0] == 'typedef':
+                    previous = tokens[-1]
+                elif tokens[0] == '#define':
+                    previous = tokens[1]
+                elif previous == '*':
+                    previous = tokens[3]
+                #print "%8s: %5d - %20s %s" % (file, start, name, previous)
+            if found != None:
+                nlist.append("%14s: %s" % (file, found))
+                #print "FOUND: %8s: %5d %s" % (file, lstart, found)
+    return nlist
+
+
+# Following string contains excluded/commented API tokens, one per line.
+# Format is:
+# token comment
+comments = """
+SND_SEQ_DLSYM_VERSION I think there is no real use in pyalsa
+
+snd_seq_open_lconf need a snd_config port for implementing it
+snd_seq_poll_descriptors_revents no real use in pyalsa
+snd_seq_system_info_copy no real use in pyalsa
+snd_seq_system_info_free no real use in pyalsa
+snd_seq_system_info_malloc snd_seq_system_info_alloca used instead
+snd_seq_system_info_sizeof currently not used
+
+snd_seq_client_info_copy no real use in pyalsa
+snd_seq_client_info_free no real use in pyalsa
+snd_seq_client_info_malloc snd_seq_client_info_alloca used instead
+snd_seq_client_pool_copy no real use in pyalsa
+snd_seq_client_pool_free no real use in pyalsa
+snd_seq_client_pool_get_client snd_seq_client_id used instead
+snd_seq_client_pool_malloc no real use in pyalsa
+snd_seq_client_pool_set_input_pool snd_seq_set_client_pool_input used instead
+snd_seq_client_pool_set_output_pool snd_seq_set_client_pool_output used instead
+snd_seq_client_pool_set_output_room snd_seq_set_client_pool_output_room used instead
+snd_seq_client_pool_sizeof currently not used
+snd_seq_set_client_pool snd_seq_set_client_pool_* used instead
+snd_seq_client_info_set_name snd_seq_set_client_name used instead
+snd_seq_client_info_sizeof currently not used
+
+snd_seq_get_port_info snd_seq_get_any_port_info used instead
+snd_seq_port_info_copy no real use in pyalsa
+snd_seq_port_info_free no real use in pyalsa
+snd_seq_port_info_malloc snd_seq_port_info_alloca used instead
+snd_seq_port_info_set_addr snd_seq_port_info_set_client, snd_seq_port_info_set_port used instead
+snd_seq_port_info_sizeof currently not used
+
+snd_seq_port_subscribe_copy no real use in pyalsa
+snd_seq_port_subscribe_free no real use in pyalsa
+snd_seq_port_subscribe_malloc snd_seq_port_subscribe_alloca used instead
+snd_seq_port_subscribe_sizeof currently not used
+snd_seq_query_subscribe_copy no real use in pyalsa
+snd_seq_query_subscribe_free no real use in pyalsa
+snd_seq_query_subscribe_get_client snd_seq_query_subscribe_get_addr used instead
+snd_seq_query_subscribe_get_index currently not used
+#snd_seq_query_subscribe_get_num_subs 
+snd_seq_query_subscribe_get_port snd_seq_query_subscribe_get_addr used instead
+snd_seq_query_subscribe_get_root currently not used
+snd_seq_query_subscribe_get_type currently not used
+snd_seq_query_subscribe_malloc no real use in pyalsa
+snd_seq_query_subscribe_set_client snd_seq_query_subscribe_set_index used instead
+snd_seq_query_subscribe_set_port snd_seq_query_subscribe_set_index used instead
+snd_seq_query_subscribe_sizeof currently not used
+"""
+
+
+print """
+*******************************
+PYALSA/ASOUNDLIB COVERAGE/USAGE
+*******************************
+
+
+Notes:
+* For re-generating this file, you need inet access (for downloading the
+  doxygen HTML from www.alsa-project.org site).
+* Some cached information about parsing is in the 'cache' directory:
+  * If you change a source file, the program will regenerate the cache.
+  * HTML API from www.alsa-project.org is never refreshed, remove manually.
+* Doxygen Modules are underlined by ======= .
+* Doxygen Sections are Underlined by ------- . The parsed sections are:
+  * CPP #defines
+  * Type definitions
+  * Enumerations
+  * Functions
+* The first line of each item is the "C Prototype". First 3 columns are:
+  * Number of times found in checked code
+  * N/A if the item is not being used/was not found
+  * EXC if the item is excluded (will not be used/implemented)
+* The next line is the one-liner documentation.
+* Following lines are usage/definition until next item.
+* There are lines that summaries the coverage, they start with '^STAT'.
+
+
+
+"""
+
+
+print_api_coverage(urls, look_constant, look_usage, comments)
+
+# print end line
+time_end = time.time()
+time_diff = time_end - time_start
+
+print """%s
+Generated for ALSA project by alsa-python-coverage.py %s
+%s UTC (%s@%s %3.3f seconds).
+""" % ("-"*72,
+       __version__,
+       time.asctime(time.gmtime(time_start)), 
+       os.getlogin(),
+       os.uname()[1],
+       time_diff
+       )
+print

--=-WLiywQWfBiAijVBD6+hh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-WLiywQWfBiAijVBD6+hh--
